import 'package:flutter/material.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/ItemGetter.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Providers/CategoryProvider/CategoryProvider.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Category/Category.dart';
import 'package:integron/Utils/DB/Products/BlocSize.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/Utils/fun/Callbcks.dart';



class PageSelectedCategory extends StatefulWidget {
  VoidCallbackCategory callbackCategory;
  List<Category> categories;
  PageSelectedCategory(this.categories, this.callbackCategory);


  @override
  _PageSelectedCategoryState createState() => _PageSelectedCategoryState();
}

class _PageSelectedCategoryState extends State<PageSelectedCategory> with AutomaticKeepAliveClientMixin<PageSelectedCategory> {

  int weiR = 0;
  int weiL = 0;

  List<BlocSize> leftColumn = [];
  List<BlocSize> rightColumn = [];

  double minusIconsSize = 0;
  double minusFontsSize = 0;




  ScrollController controllerScroll = ScrollController();


  void getItemsfromServ()async{
    List<BlocSize> list = [];
    list = await CategoryProvider.getItemsCategory(widget.categories[0].route);
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: selectCategory(),
              ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(leftColumn.length, (index) => ItemGetter(leftColumn[index], context, minusFontsSize, minusIconsSize, voidCallbackCategory: widget.callbackCategory )) ,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: List.generate(rightColumn.length, (index) => ItemGetter(rightColumn[index], context, minusFontsSize, minusIconsSize,voidCallbackCategory: widget.callbackCategory)) ,
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

  Widget selectCategory(){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(240, 245, 239, 1),
            borderRadius: BorderRadius.circular(6),

          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: getIconSvg(id: widget.categories[0].icon, color: c6287A1, size: 20,),
                ),
                SizedBox(width: 8,),
                Text(widget.categories[0].name, style: TextStyle(
                  color: Colors.black, fontSize: 24, fontWeight: FontWeight.w400, fontFamily: fontFamily
                ),),
                SizedBox(width: 8,),
                GestureDetector(
                  onTap:(){
                    widget.callbackCategory(widget.categories[0]);
                  },
                  child: Container(
                    child: getIconSvg(id:8, color: c6287A1, size: 18,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  @override

  bool get wantKeepAlive => SaveStateCatalog;
}
