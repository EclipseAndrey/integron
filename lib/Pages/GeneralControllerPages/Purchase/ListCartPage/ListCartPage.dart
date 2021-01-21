import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/AAPages/Blocs/Cart/CartCubit.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/TovarInfo/TovarInfo.dart';
import 'package:integron/Pages/GeneralControllerPages/Purchase/Formalize/FormalizePage.dart';
import 'package:integron/REST/Cart/updateCart.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/main.dart';

class ListCartPage extends StatefulWidget {
  final int type;
  ListCartPage({@required this.type}): assert(type != null && type >= 0);


  @override
  _ListCartPageState createState() => _ListCartPageState();
}

class _ListCartPageState extends State<ListCartPage> {
  double paddingAll = 12;



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit,CartState>(
        builder: (context, state){
          if(state is CartLoading){
            return Center(child: CircularProgressIndicator(),);
          }else if(state is CartComplete){

            return Content(state);

          }else{
            return Center();//todo err
          }
        });
  }

  Content(CartComplete state){




    bool checkOwnrFull(index){

      try{
        bool find = true;
        for(int i = 0; i < getSortListForType(state)[index].length; i++){
          if(!(getSortListForType(state)[index][i].check)) find = false;
        }
        print(find);
        return find;
      }catch(e){return false;}
    }

    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width - paddingAll*2,
            height: MediaQuery.of(context).size.height-30,
            child: Column(
              children: [
                Container(
                  height: (getSortListForType(state).length) == 0?0:!(widget.type==0)?0:50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      counterProducts(state),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height-130,
                  width: MediaQuery.of(context).size.width - paddingAll*2,
                  child: (getSortListForType(state).length)==0?Center(child: Text("Тут пусто :)", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontSize: 24),),):
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(getSortListForType(state).length, (indexAll) =>
                              Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                            onTap:(){
                                              // BlocProvider.of<TovarsCubit>(context1).load();

                                              if(widget.type == 0){
                                                BlocProvider.of<CartCubit>(context).checkT(state, indexAll);
                                              }else if(widget.type == 1){
                                                BlocProvider.of<CartCubit>(context).checkU(state, indexAll);
                                              }else if(widget.type == 2){
                                                BlocProvider.of<CartCubit>(context).checkR(state, indexAll);
                                              }
                                              // widget.tovar?BlocProvider.of<CartCubit>(context).checkT(state, indexAll):BlocProvider.of<CartCubit>(context).checkU(state, indexAll);

                                            },
                                            child: getIconSvg(id: checkOwnrFull(indexAll)?IconsSvg.checkOn:IconsSvg.checkOff, color: c6287A1, size: 24)),
                                        SizedBox(width: paddingAll,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(  getSortListForType(state)[indexAll][0].ownerName, style: TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily, fontWeight: FontWeight.w600),),
                                            getIconSvg(id: 39, color: c6287A1, size: 24),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8,),
                                    Divider(color: cDefault,),
                                  ],
                                ),
                              ),
                              Column( children: List.generate(getSortListForType(state)[indexAll].length, (index) => ItemCart(indexAll, index, state)),),
                            ],
                          )),
                        ),
                        SizedBox(height: 100,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: (getSortListForType(state).length) ==0?SizedBox():EndPrice(getSumForType(state), state),
        )
      ],
    );
  }

  EndPrice(double summ, CartComplete state) {



    Widget total() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Итого: ', style: TextStyle(color: cMainText, fontWeight: FontWeight.w400, fontFamily: fontFamily, fontSize: 16),),
          Text(summ.toString(), style: TextStyle(color: c5894bc, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 16),),
          Text(' DEL', style: TextStyle(color: cMainText, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 16),),
        ],
      );
    }

    Widget buttonPay(CartComplete state) {
      return GestureDetector(
        onTap: ()async{
          List<Product> list = [];
          for(int i = 0; i < state.cartList.length;i++){
            if(state.cartList[i].check ){ //&&(state.cartList[i].type == (widget.tovar?0:1))
              list.add(state.cartList[i]);
            }
          }
          await  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context1) => FormalizePage(list, context)));
        },
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 0, 0, 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(child: Text("Оформить", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500, ),)),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0, left: 12, right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: cBG,
            width: MediaQuery.of(context).size.width- paddingAll*2,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  total(),
                  buttonPay(state),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width- paddingAll*2,
            height: 50,
            color: cBG,
          )
        ],
      ),
    );
  }

  Widget ItemCart(int indexAll, int index, CartComplete state){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TovarInfo(getSortListForType(state)[indexAll][index].route)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width-paddingAll*2,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: paddingAll,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap:(){
                              // BlocProvider.of<TovarsCubit>(context1).load();

                              if(widget.type == 0){
                                BlocProvider.of<CartCubit>(context).checkT(state, indexAll, index: index);
                              }else if(widget.type == 1){
                                BlocProvider.of<CartCubit>(context).checkU(state, indexAll, index: index);
                              }else if(widget.type == 2){
                                BlocProvider.of<CartCubit>(context).checkR(state, indexAll, index: index);
                              }


                              // widget.tovar?BlocProvider.of<CartCubit>(context).checkT(state, indexAll, index: index ):BlocProvider.of<CartCubit>(context).checkU(state, indexAll, index: index);

                            },
                            child: getIconSvg(id: (getSortListForType(state)[indexAll][index].check)?IconsSvg.checkOn:IconsSvg.checkOff, color: c6287A1, size: 24)),
                        SizedBox(width: paddingAll,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                              height: 84 ,
                              child: Image.network(getSortListForType(state)[indexAll][index].image, height: 84, width: 84, fit: BoxFit.cover,),),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getSortListForType(state)[indexAll][index].name, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: cMainText, fontFamily: fontFamily),),
                          Container(
                            // width: MediaQuery.of(context).size.width-paddingAll*2- 108,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (getSortListForType(state)[indexAll][index].params.length)==0?SizedBox(height: paddingAll,):Padding(
                                  padding:  EdgeInsets.symmetric(vertical: paddingAll),
                                  child: Wrap(
                                    children:
                                    List.generate(getSortListForType(state)[indexAll][index].params.length, (indexC) => Padding(
                                      padding:  EdgeInsets.only(right: paddingAll),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          //border: item.params[index].select?Border.all(color: c8dcde0):null,
                                          color: cForms,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                          child: Text(getSortListForType(state)[indexAll][index].params[indexC].params[getSortListForType(state)[indexAll][index].params[indexC].select].name, style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400),),
                                        ),
                                      ),
                                    ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        price(indexAll,index, state),
                                        unit(indexAll, index, state),
                                      ],
                                    ),
                                    // Spacer(),

                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                GestureDetector(
                    onTap:(){
                      BlocProvider.of<CartCubit>(context).remove( getSortListForType(state)[indexAll][index].route , state: state);
                    },
                    child: Container(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: getIconSvg(id: 8, color: c6287A1, size: 18),
                    ))),
                SizedBox(width: 8,),
                counterSelect(indexAll, index, state),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget price(int indexAll, int index, CartComplete state){
    return Row(
      children: [
        Text( getSortListForType(state)[indexAll][index].price.toString(), style: TextStyle(color:  c6287A1, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: fontFamily),),
        Text(" DEL" , style: TextStyle(color:  cMainText, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: fontFamily), ),
      ],
    );
  }

  Widget unit(int indexAll,int index, CartComplete state){
    String getRub(){
      return (getSortListForType(state)[indexAll][index].price*course).toString();
    }
    return Row(
      children: [
        Text("(~",  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
        Text(getRub(),  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
        Text("₽",  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400),),
        Text(") / ",  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
        Text(getSortListForType(state)[indexAll][index].unit,  style: TextStyle(color:  Colors.grey , fontSize: 14, fontWeight: FontWeight.w400, fontFamily: fontFamily),),
      ],
    );
  }

  Widget counterSelect(int indexAll,int index, CartComplete state){
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, //Color.fromRGBO(240,245,239,1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Text(getSortListForType(state)[indexAll][index].counter.toString(), style: TextStyle(color: c5894bc, fontFamily: fontFamily, fontWeight: FontWeight.w600, fontSize: 14),),
      ),
    );
  }



  Widget counterProducts(CartComplete state){
    String cont(){
        int c = 0;
        for(int i =0; i < getSortListForType(state).length; i++){
          for(int j = 0; j < getSortListForType(state)[i].length; j++){
            c++;
          }
        }
        return c.toString();

    }


    if((getSortListForType(state).length) == 0 || !(widget.type == 0)){
      return SizedBox();
    }else{
      return Text("Итого ${cont()} ${getNameType()} в корзине", style: TextStyle(fontSize: 14, fontFamily: fontFamily, fontWeight: FontWeight.w400, color: Color.fromRGBO(122,139,163,1)),);
    }
  }




  List<List<Product>> getSortListForType(CartComplete state){
    switch(widget.type){
      case 0: return state.sortListTovars;
      case 1: return state.sortListUslugi;
      case 2: return state.sortListTrainings;
      default: return [];
    }
  }

  double getSumForType(CartComplete state){
    switch(widget.type){
      case 0: return state.summT;
      case 1: return state.summU;
      case 2: return state.summR;
      default: return 0;
    }
  }

  String getNameType(){
    switch(widget.type){
      case 0: return "Товаров";
      case 1: return "Услуг";
      case 2: return "Тренингов";
      default: return "";
    }
  }
}





