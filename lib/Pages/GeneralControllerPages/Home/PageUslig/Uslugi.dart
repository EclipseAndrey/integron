import 'package:flutter/material.dart';
import 'package:omega_qick/Authorization/Pages/PageNum2/Style.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/ItemGetter.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/REST/Home/GetItems.dart';
import 'package:omega_qick/Utils/DB/Items/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Items/Category.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/fun/Callbcks.dart';

import 'Panel/Panel.dart';

class Uslugi extends StatefulWidget {
  VoidCallbackCategory callbackCategory;
  Uslugi(this.callbackCategory);

  @override
  _UslugiState createState() => _UslugiState();
}

class _UslugiState extends State<Uslugi> with AutomaticKeepAliveClientMixin<Uslugi> {

  int weiR = 0;
  int weiL = 0;

  List<BlocSize> leftColumn = [];
  List<BlocSize> rightColumn = [];

  double minusIconsSize = 0;
  double minusFontsSize = 0;




  ScrollController controllerScroll = ScrollController();

  ProductShort product   = ProductShort(name: "Массаж",image: "https://massagkrasnodar.ru/wp-content/uploads/2018/07/th3.jpg",route: 1,text: "Внутри косарь",price:77,sale:null);
  Category category =  Category(name: "Здоровье",image: "https://grodnonews.by/upload/iblock/aa4/aa4a03c54a1354faebc0d0be72099d0f.jpg",route: 1, colors: [c2f527f, c7A8BA3, c2f527f], icon: 1);


  void getItemsfromServ()async{
    List<BlocSize> list = [];
    list = await getItems(type: 1);
    for(int i = 0; i < list.length; i+=2){

      leftColumn.add(list[i]);
      rightColumn.add(list[i+1]);
    }
    setState(() {

    });
  }



   @override
  void initState() {
    getItemsfromServ();
    controllerScroll.addListener(() {

      //print("listen scroll ${controllerScroll.position.pixels} // ${controllerScroll.position.maxScrollExtent}");
     // print(controllerScroll.position.pixels.toString()+ " "  + controllerScroll.position.maxScrollExtent. toString());
      if(controllerScroll.position.pixels == controllerScroll.position.maxScrollExtent){
        print(controllerScroll.position.pixels);
        getItemsfromServ();
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
      child: Container(
        color: cBG,
        child: Column(
          children: [
            MainPanel(context, product, category),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

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
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => SaveStateCatalog;
}
