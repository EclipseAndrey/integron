import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/Providers/CartProvider/CartProvider.dart';
import 'package:integron/Utils/DB/Products/Product.dart';

part 'CartStates.dart';


class CartCubit extends Cubit<CartState>{
  CartCubit():super(CartLoading()){load();}

  load  ()async{
    List<Product> listTovars = [];
    List<Product> listUslug = [];
    List<Product> listTrainings = [];


    List<Product> cartList = await CartProvider.getCart();

    List<List<Product>> sortListUslug = [];
    List<List<Product>> sortListTovars = [];
    List<List<Product>> sortListTrainings = [];
    double summT = 0;
    double summU = 0;
    double summR = 0;


    //Разделение по типам
    for(int i = 0; i < cartList.length; i++){

              if(cartList[i].type ==0 ){
        listTovars.add(cartList[i]);
      } else if (cartList[i].type == 1){
        listUslug.add(cartList[i]);
      } else if (cartList[i].type == 2){
        listTrainings.add(cartList[i]);
      }
    }

    //Сортировка по Владельцам товаров
    for(int i = 0; i < listTovars.length; i++){
      bool find = false;
      for(int j = 0; j < sortListTovars.length; j ++){
        if(sortListTovars[j][0].ownerName == listTovars[i].ownerName){
          sortListTovars[j].add(listTovars[i]);
          find = true;
        }
      }
      if(!find){
        sortListTovars.add([listTovars[i]]);
      }
    }

    //Сортировка по владельцам услуг
    for(int i = 0; i < listUslug.length; i++){
      bool find = false;
      for(int j = 0; j < sortListUslug.length; j ++){
        if(sortListUslug[j][0].ownerName == listUslug[i].ownerName){
          sortListUslug[j].add(listUslug[i]);
          find = true;
        }
      }
      if(!find){
        sortListUslug.add([listUslug[i]]);
      }
    }

    //Сортировка по владельцам тренингов
    for(int i = 0; i < listTrainings.length; i++){
      bool find = false;
      for(int j = 0; j < sortListTrainings.length; j ++){
        if(sortListTrainings[j][0].ownerName == listTrainings[i].ownerName){
          sortListTrainings[j].add(listTrainings[i]);
          find = true;
        }
      }
      if(!find){
        sortListTrainings  .add([listTrainings[i]]);
      }
    }


    //Подсчет суммы товаров
    for(int i = 0; i <  listTovars.length; i++){
      if(listTovars[i].check)summT+=listTovars[i].price*listTovars[i].counter;
    }

    //Подсчет суммы услуг
    for(int i = 0; i <  listUslug.length; i++){
      if(listUslug[i].check)summU+=listUslug[i].price*listUslug[i].counter;
    }

    //Подсчет суммы тренингов
    for(int i = 0; i <  listTrainings.length; i++){
      if(listTrainings[i].check)summR+=listTrainings[i].price*listTrainings[i].counter;
    }


    emit(CartComplete(
      cartList: cartList,
      sortListTovars: sortListTovars,
      sortListUslugi: sortListUslug,
      sortListTrainings: sortListTrainings,
      summT: summT,
      summU: summU,
      summR: summR,
    ));

  }

  checkU(CartComplete state, int owner, {int index}){

    if(index == null){
      bool on = true;
      for(int i = 0 ; i < state.sortListUslugi[owner].length; i++){
        if(!state.sortListUslugi[owner][i].check){
          on = false; i = state.sortListUslugi[owner].length;
        }
      }
      for(int i = 0 ; i < state.sortListUslugi[owner].length; i++){
         state.sortListUslugi[owner][i].check = !on;
      }
    }else{
      state.sortListUslugi[owner][index].check = !state.sortListUslugi[owner][index].check;
    }
    double summT = _sortSumm(state.sortListTovars);
    double summU = _sortSumm(state.sortListUslugi);

    CartComplete stateOut = CartComplete(summT: summT, summU: summU, sortListTovars: state.sortListTovars, sortListUslugi: state.sortListUslugi, cartList : state.cartList , sortListTrainings: state.sortListTrainings, summR: state.summR);

    emit(CartLoading());
    emit(stateOut);
  }


  checkT(CartComplete state, int owner, {int index}){
    print('checkT');
    if(index == null){
      bool on = true;
      for(int i = 0 ; i < state.sortListTovars[owner].length; i++){
        if(!state.sortListTovars[owner][i].check){
          on = false; i = state.sortListTovars[owner].length;
        }
      }
      for(int i = 0 ; i < state.sortListTovars[owner].length; i++){
        state.sortListTovars[owner][i].check = !on;
      }
    }else{
      state.sortListTovars[owner][index].check = !state.sortListTovars[owner][index].check;
    }



    double summT = _sortSumm(state.sortListTovars);
    double summU = _sortSumm(state.sortListUslugi);

    CartComplete stateOut = CartComplete(summT: summT, summU: summU, sortListTovars: state.sortListTovars, sortListUslugi: state.sortListUslugi, cartList : state.cartList , sortListTrainings: state.sortListTrainings, summR: state.summR);

    emit(CartLoading());
    emit(stateOut);
  }

  checkR(CartComplete state, int owner, {int index}){
    print('checkT');
    if(index == null){
      bool on = true;
      for(int i = 0 ; i < state.sortListTrainings[owner].length; i++){
        if(!state.sortListTrainings[owner][i].check){
          on = false; i = state.sortListTrainings[owner].length;
        }
      }
      for(int i = 0 ; i < state.sortListTrainings[owner].length; i++){
        state.sortListTrainings[owner][i].check = !on;
      }
    }else{
      state.sortListTrainings[owner][index].check = !state.sortListTrainings[owner][index].check;
    }



    double summT = _sortSumm(state.sortListTovars);
    double summU = _sortSumm(state.sortListUslugi);
    double summR = _sortSumm(state.sortListTrainings);

    CartComplete stateOut = CartComplete(summT: summT, summR: summR, summU: summU, sortListTovars: state.sortListTovars, sortListUslugi: state.sortListUslugi, cartList : state.cartList , sortListTrainings: state.sortListTrainings);

    emit(CartLoading());
    emit(stateOut);
  }

  remove( int route, {CartComplete state})async{

    List<Product> cartList = state?.cartList??await CartProvider.getCart();

    //удаление элемента
    for(int i =0; i < cartList.length; i++){
      if(cartList[i].route == route){
        cartList.removeAt(i);
        i = cartList.length+1;
      }
    }

    //Обновление корзины
    CartProvider.updateCart(cartList);

    load();
    // if(state != null) {
    //   List<Product> listTovars = [];
    //   List<Product> listUslug = [];
    //   List<List<Product>> sortListUslug = [];
    //   List<List<Product>> sortListTovars = [];
    //   double summT = 0;
    //   double summU = 0;
    //
    //   //Разделение по типам
    //   for (int i = 0; i < cartList.length; i++) {
    //     int a = 0;
    //     listTovars.add(cartList[i]);///
    //     if (cartList[i].type == a) {
    //       listTovars.add(cartList[i]);
    //     } else {
    //       listUslug.add(cartList[i]);
    //     }
    //   }
    //
    //   //Сортировка по Владельцам товаров
    //   for (int i = 0; i < listTovars.length; i++) {
    //     bool find = false;
    //     for (int j = 0; j < sortListTovars.length; j ++) {
    //       if (sortListTovars[j][0].ownerName == listTovars[i].ownerName) {
    //         sortListTovars[j].add(listTovars[i]);
    //         find = true;
    //       }
    //     }
    //     if (!find) {
    //       sortListTovars.add([listTovars[i]]);
    //     }
    //   }
    //
    //   //Сортировка по владельцам услуг
    //   for (int i = 0; i < listUslug.length; i++) {
    //     bool find = false;
    //     for (int j = 0; j < sortListUslug.length; j ++) {
    //       if (sortListUslug[j][0].ownerName == listUslug[i].ownerName) {
    //         sortListUslug[j].add(listUslug[i]);
    //         find = true;
    //       }
    //     }
    //     if (!find) {
    //       sortListUslug.add([listUslug[i]]);
    //     }
    //   }
    //
    //   // //Подсчет суммы товаров
    //   // for (int i = 0; i < listTovars.length; i++) {
    //   //   if (listTovars[i].check) summT += listTovars[i].price*listTovars[i].counter;
    //   // }
    //   //
    //   // //Подсчет суммы услуг
    //   // for (int i = 0; i < listUslug.length; i++) {
    //   //   if (listUslug[i].check) summU += listUslug[i].price*listUslug[i].counter;
    //   // }
    //
    //
    //   emit(CartComplete(
    //     cartList: cartList,
    //     sortListTovars: sortListTovars,
    //     sortListUslugi: sortListUslug,
    //     summT: _sortSumm(sortListTovars),
    //     summU: _sortSumm(sortListUslug),
    //   ));
    // }else{
    //   load();
    // }
  }

  add(Product product)async {
    if (product.type != 3){
      List<Product> list = await CartProvider.getCart();
    bool find = false;
    for (int i = 0; i < list.length; i++) {
      if (list[i].route == product.route) {
        list[i].counter++;
        i = list.length;
        find = true;
      }
    }
    if (!find) {
      list.add(product..counter = 1);
    }
    CartProvider.updateCart(list);
    load();
  }

  }


  double _sortSumm(List<List<Product>> sortList){
    double s = 0;
    for(int i = 0; i < sortList.length; i++){
      for(int j = 0; j < sortList[i].length; j++){
        if(sortList[i][j].check)s+= sortList[i][j].price*sortList[i][j].counter;
      }
    }
    return s;
  }

}























