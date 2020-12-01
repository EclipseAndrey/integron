import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_qick/AAPages/Blocs/Feed/UslugiCubit.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/ItemGetter.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Providers/ProductProvider/ProductProvider.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/Utils/DB/Category/Category.dart';
import 'package:omega_qick/Utils/DB/Products/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Products/Product.dart';
import 'package:omega_qick/Utils/fun/Callbcks.dart';

import 'Panel/Panel.dart';

class Uslugi extends StatefulWidget {
  VoidCallbackCategory callbackCategory;
  PageController controllerPages;

  Uslugi(this.callbackCategory,this.controllerPages);

  @override
  _UslugiState createState() => _UslugiState();
}

class _UslugiState extends State<Uslugi> with AutomaticKeepAliveClientMixin<Uslugi> {


  double minusIconsSize = 0;
  double minusFontsSize = 0;




  ScrollController controllerScroll = ScrollController();

  ProductShort product   = ProductShort(name: "Массаж",image: "https://massagkrasnodar.ru/wp-content/uploads/2018/07/th3.jpg",route: 1,text: "Внутри косарь",price:77,sale:null);
  Category category =  Category(name: "Здоровье",image: "https://grodnonews.by/upload/iblock/aa4/aa4a03c54a1354faebc0d0be72099d0f.jpg",route: 1, colors: [c2f527f, c7A8BA3, c2f527f], icon: 1);




   @override
  void initState() {
    controllerScroll.addListener(() {
      //print("listen scroll ${controllerScroll.position.pixels} // ${controllerScroll.position.maxScrollExtent}");
     // print(controllerScroll.position.pixels.toString()+ " "  + controllerScroll.position.maxScrollExtent. toString());
      if(controllerScroll.position.pixels == controllerScroll.position.maxScrollExtent){
        print(controllerScroll.position.pixels);
        //todo autoload
      }
    });

  }


  // @override
  // void dispose() {
  //   controllerScroll.dispose();
  //   super.dispose();
  // }



  @override
  Widget build(BuildContext context, ) {

    double shortestSide = MediaQuery.of(context).size.shortestSide;

    if(shortestSide < 400){
      minusIconsSize = minusIconsSizeHome400;
      minusFontsSize = minusFontsSizeHome400;
    }


    super.build(context);
    return SingleChildScrollView(
      controller: controllerScroll,
      child: BlocBuilder<UslugiCubit,UslugiState>(
        builder: (context,state){
          if(state is UslugiLoading){
            return Center(child:  CircularProgressIndicator(),);
          }else if(state is UslugiComplete){
            return Loaded(state);
          }else{
            return Center(
              //todo err
            );
          }
        },
      ),
    );
  }

  Widget Loaded(UslugiComplete uslugiComplete){

    List<BlocSize> leftColumn = [];
    List<BlocSize> rightColumn = [];

    List<BlocSize> list = uslugiComplete.uslugiList;
    for(int i = 0; i < list.length; i+=2){

      try{
        leftColumn.add(list[i]);
      }catch(e){}

      try {
        rightColumn.add(list[i + 1]);
      }catch(e){}
    }



    return  Container(
      color: cBG,
      child: Column(
        children: [
          MainPanel(context, product, category,widget.controllerPages ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: List.generate(leftColumn.length, (index) => ItemGetter(leftColumn[index], context, minusFontsSize, minusIconsSize, voidCallbackCategory: widget.callbackCategory)) ,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: List.generate(rightColumn.length, (index) => ItemGetter(rightColumn[index], context, minusFontsSize, minusIconsSize,  voidCallbackCategory: widget.callbackCategory)) ,
                ),
              ],
            ),
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
