import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/GeneralControllerPages/My/Favorite/FavoriteList.dart';
import 'package:integron/Providers/ProductProvider/ProductProvider.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Products/Product.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/Utils/fun/DialogLoading/DialogLoading.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool loading = true;

  List<Product> listFavorit = [];


  load()async{
    listFavorit = await ProductProvider.getFavorites();
    loading = false;
    setState(() {});
  }


  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle//.dark
        (
        //statusBarColor: cBackground,
        systemNavigationBarColor: Color(0x00cccccc),
        systemNavigationBarDividerColor: Color(0x00cccccc),
        statusBarColor: Color(0xFFffffff),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    load();
    setState(() {});

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -50,
          child: loading?Center(child:  CircularProgressIndicator(),):Content(),
        ),
      ),
    );
  }



  Widget Content(){
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              HeaderFavorite(),
              Container(
                  height: MediaQuery.of(context).size.height - 80,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                      height: MediaQuery.of(context).size.height - 80,
                      width: MediaQuery.of(context).size.width,
                      child: listFavorit.length == 0?_Empty():FavoriteList(listFavorit, (){load();})),
              )
            ],
          ),
        ),

      ],
    );
  }

  Widget _Empty (){
    return Center(
      child: Text("Тут пусто :)", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontSize: 24),)
    );
  }


  HeaderFavorite() {
    return Container(
      decoration: BoxDecoration(
        color: cBG,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(42,59,83,0.1),
            spreadRadius: 10,
            blurRadius: 30,
            offset: Offset(0, 30), // changes position of shadow
          ),

        ],
      ),
      width: MediaQuery.of(context).size.width,
      height: 56,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text("Избранное", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontStyle: FontStyle.normal,fontWeight: FontWeight.w400, fontSize: 24),)),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:  EdgeInsets.all(12),
              child: GestureDetector(
                  onTap: (){
                    closeDialog(context);
                  },
                  child: getIconSvg(id: 0, color: cIcons)),
            ),
          )
        ],
      ),
    );
  }

}

