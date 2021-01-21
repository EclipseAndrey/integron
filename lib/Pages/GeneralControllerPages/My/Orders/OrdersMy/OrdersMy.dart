import 'package:flutter/material.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/GeneralControllerPages/My/Orders/OrdersBiz/OrdersBizContent.dart';
import 'package:integron/Pages/GeneralControllerPages/Purchase/ListCartPage/ListCartPage.dart';
import 'package:integron/Providers/OrderProvider/OrderProvider.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Orders/Order.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/Utils/fun/DialogLoading/DialogLoading.dart';
import 'package:integron/Utils/fun/Logs.dart';
import 'package:integron/main.dart';
import 'package:flutter/services.dart';

import 'OrdersMyContent.dart';

class OrdersMy extends StatefulWidget {
  @override
  _OrdersMyState createState() => _OrdersMyState();
}

class _OrdersMyState extends State<OrdersMy> {

  bool loading = true;



  List<Order> listOrders = [];
  List<Order> listOrdersTovars = [];
  List<Order> listOrderssUslugi = [];
  List<Order> listOrdersTrainings = [];


  PageController controllerPage;




  load()async{
    loading = true;
    listOrders = await OrderProvider.getOrders();
    for(int i =0;i<listOrders.length;i++){
      try{
        if(listOrders[i].products[0].type == 0){
          listOrdersTovars.add(listOrders[i]);
        }else if(listOrders[i].products[0].type == 1){
          listOrderssUslugi.add(listOrders[i]);
        } else if(listOrders[i].products[0].type == 0){
          listOrdersTrainings.add(listOrdersTrainings[i]);
        }
      }catch(e){printL(e);}
    }
    loading = false;
    setState(() {

    });
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
    controllerPage = PageController(initialPage: 0);
    controllerPage.addListener(() {setState(() {});});
    setState(() {

    });

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

  int getCurrentPageOfList(){
    try {
      // print(controllerPage.page.round());
      return controllerPage.page.round();
    }catch(e){
      // print(0);

      return 0;
    }
  }

  int getCountCurrentType(){
    int s = 0;
    for(int i = 0; i < listOrders.length; i++){
      if(listOrders[i].products[0].type == getCurrentPageOfList()){s++;}
    }
    return s;
  }



  Widget Content() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              HeaderCart(),
              Container(
                  height: MediaQuery.of(context).size.height - 80,
                  width: MediaQuery.of(context).size.width,
                  child: listOrdersTovars == null?Center(child:  Text(
                    "Не удалось загрузить\nПопробуйте позже", textAlign: TextAlign.center, style: TextStyle(color: cMainText, fontSize: 16, fontFamily: fontFamily),
                  ),):PageView(
                    children: [
                      OrdersBizContent(stateCallback: (){setState(() {});},orders: listOrdersTovars,),
                      OrdersBizContent(stateCallback: (){setState(() {});}, orders: listOrderssUslugi,),
                      OrdersBizContent(stateCallback: (){setState(() {});}, orders: listOrdersTrainings,),
                    ],
                    controller: controllerPage,

                  )),
            ],
          ),
        ),

      ],
    );
  }

  HeaderCart() {
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
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    controllerPage.animateToPage(0, duration: Duration(milliseconds: 100), curve: Curves.ease);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: 34,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6)),
                        color: 0 == getCurrentPageOfList() ? c8dcde0: Colors.white  ,
                        border: Border.all(color: cDefault, width: 1)),
                    child: Center(
                      child: Text("Товары", style:  TextStyle(color: getCurrentPageOfList()==0 ? Colors.white:cMainText, fontWeight: FontWeight.w600, fontSize: 16, fontFamily: fontFamily ),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    controllerPage.animateToPage(1, duration: Duration(milliseconds: 100), curve: Curves.ease);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: 34,
                    decoration: BoxDecoration(

                        color: getCurrentPageOfList() == 1
                            ? c8dcde0: Colors.white,
                        border: Border.all(color: cDefault, width: 1)),
                    child: Center(
                      child: Text("Услуги", style:  TextStyle(color: getCurrentPageOfList()==1 ?  Colors.white: cMainText, fontWeight: FontWeight.w600, fontSize: 16, fontFamily: fontFamily ),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    controllerPage.animateToPage(2, duration: Duration(milliseconds: 100), curve: Curves.ease);
                  },
                  child: Container(
                    // width: MediaQuery.of(context).size.width * 0.20,
                    height: 34,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6)),
                        color: getCurrentPageOfList() == 2
                            ? c8dcde0: Colors.white,
                        border: Border.all(color: cDefault, width: 1)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: Text("Обучение", style:  TextStyle(color: getCurrentPageOfList()==2 ?  Colors.white: cMainText, fontWeight: FontWeight.w600, fontSize: 16, fontFamily: fontFamily ),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: Text("Мои покупки", style: TextStyle(color: cMainText, fontFamily: fontFamily, fontStyle: FontStyle.normal,fontWeight: FontWeight.w400, fontSize: 24)),
          // ),
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

