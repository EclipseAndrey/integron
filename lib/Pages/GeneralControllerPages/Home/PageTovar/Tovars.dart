import 'package:flutter/material.dart';
import 'package:omega_qick/Authorization/Pages/PageNum2/Style.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/PageUslig/Panel/Panel.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/REST/Home/GetItems.dart';
import 'package:omega_qick/Utils/DB/Items/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Items/Category.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/fun/Callbcks.dart';

import '../ItemGetter.dart';




// abstract class callCategory{
//
//   callCategory();
// }


class Tovars extends StatefulWidget {

  VoidCallbackCategory callbackCategory;

  Tovars(this.callbackCategory);



  @override
  _TovarsState createState() => _TovarsState();
}

class _TovarsState extends State<Tovars> with AutomaticKeepAliveClientMixin<Tovars>{
  int weiR = 0;
  int weiL = 0;



  double minusIconsSize = 0;
  double minusFontsSize = 0;

  List<BlocSize> leftColumn = [];
  List<BlocSize> rightColumn = [];

  ScrollController controllerScroll = ScrollController();

  ProductShort product   = ProductShort(name: "кНИГГА",image: "https://img4.goodfon.com/wallpaper/nbig/4/98/tavern-kniga-monety-art-fentezi-svecha-ozan-temelli.jpg",route: 1,text: "Внутри косарь",price:77,sale:null);
  Category category =  Category(name: "Одежда",image: "https://get.wallhere.com/photo/illustration-anime-anime-girls-cartoon-headphones-Super-Sonico-screenshot-computer-wallpaper-93802.png",route: 1, colors: [c2f527f, c7A8BA3, c2f527f],icon: 1);


  void getItemsfromServ()async{
    List<BlocSize> list = [];
    list = await getItems(type: 0);
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
      // print(controllerScroll.position.pixels.toString()+ " "  + controllerScroll.position.maxScrollExtent. toString());
      if(controllerScroll.position.pixels == controllerScroll.position.maxScrollExtent){
        print(controllerScroll.position.pixels);
        getItemsfromServ();
      }
    });

  }





  @override
  Widget build(BuildContext context) {


    double shortestSide = MediaQuery.of(context).size.shortestSide;

    if(shortestSide < 400){
      minusIconsSize = minusIconsSizeHome400;
      minusFontsSize = minusFontsSizeHome400;
    }

    super.build(context);
    return SingleChildScrollView(
      controller: controllerScroll,
      child: Container(
        color: cBackground,
        child: Column(
          children: [
            MainPanel(context, product,category),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(leftColumn.length, (index) => ItemGetter(leftColumn[index], context, minusFontsSize, minusIconsSize, voidCallbackCategory: widget.callbackCategory)) ,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: List.generate(rightColumn.length, (index) => ItemGetter(rightColumn[index], context, minusFontsSize, minusIconsSize, voidCallbackCategory: widget.callbackCategory)) ,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>  SaveStateCatalog;
}
