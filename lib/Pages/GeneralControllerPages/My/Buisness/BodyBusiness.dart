import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/ItemGetter.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/REST/Home/Search/getItemCategory.dart';
import 'package:omega_qick/Utils/DB/Items/BlocSize.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';

class BodyBusiness extends StatefulWidget {

  bool edit;
  int type;
  BodyBusiness({this.type, this.edit});

  @override
  _BodyBusinessState createState() => _BodyBusinessState();
}

class _BodyBusinessState extends State<BodyBusiness> {

  int weiR = 0;
  int weiL = 0;

  double minusIconsSize = 0;
  double minusFontsSize = 0;

  List<BlocSize> leftColumn = [];
  List<BlocSize> rightColumn = [];


  ScrollController controllerScroll = ScrollController();

  void getItemsfromServ()async{
    List<BlocSize> list = widget.edit?[Product(ownerName: null, delivery: null, fullText: null, unit: null, detail: [], text: null, type: null, catPath: [], property: [], name: null, image: null, owner: null, price: null, images: [    ], route: null)]:[];
    list = await getItemsCategory(1);
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
      if(controllerScroll.position.pixels > controllerScroll.position.maxScrollExtent){
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

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: cBG,
      child: SingleChildScrollView(
        controller: controllerScroll,
        child: Container(
          color: cBG,
          child: Column(
            children: [
              gen()
            ],
          ),
        ),
      ),
    );
  }

  Widget gen (){
    if(leftColumn.length > 0 || rightColumn.length  >0){
      return  Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(leftColumn.length, (index) => ItemGetter(leftColumn[index], context, minusFontsSize, minusIconsSize, add: (index == 0&&widget.edit)? true:false)) ,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: List.generate(rightColumn.length, (index) => ItemGetter(rightColumn[index], context, minusFontsSize, minusIconsSize,)) ,
              ),
            ],
          ),
          SizedBox(height: 50,),
        ],
      );
    }else return Center(
      child: Text("Скоро будут товары :)", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontSize: 24),),
    );
  }




  @override

  bool get wantKeepAlive => SaveStateCatalog;
}
