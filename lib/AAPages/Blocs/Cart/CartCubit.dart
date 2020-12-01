import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_qick/Providers/CartProvider/CartProvider.dart';
import 'package:omega_qick/Utils/DB/Products/Product.dart';

part 'CartStates.dart';


class CartCubit extends Cubit<CartState>{
  CartCubit():super(CartLoading()){load();}

  load()async{
    List<Product> listTovars = [];
    List<Product> listUslug = [];
    List<Product> cartList = await CartProvider.getCart();
    List<List<Product>> sortListUslug = [];
    List<List<Product>> sortListTovars = [];
    double summT = 0;
    double summU = 0;

    //Разделение по типам
    for(int i = 0; i < cartList.length; i++){
      int a = 0;
      if(cartList[i].type ==a ){
        listTovars.add(cartList[i]);
      } else {
        listUslug.add(cartList[i]);
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

    //Подсчет суммы товаров
    for(int i = 0; i <  listTovars.length; i++){
      if(listTovars[i].check)summT+=listTovars[i].price;
    }

    //Подсчет суммы услуг
    for(int i = 0; i <  listUslug.length; i++){
      if(listUslug[i].check)summU+=listUslug[i].price;
    }


    emit(CartComplete(
      cartList: cartList,
      sortListTovars: sortListTovars,
      sortListUslugi: sortListUslug,
      summT: summT,
      summU: summU,
    ));

  }

  checkU(CartComplete state, int owner, {int route}){

    if(route == null){
      bool on = true;


    }else{

    }

  }
  checkT(CartComplete state, int owner, {int route}){

  }

  removeT(){

  }
  removeU(){

  }

}























