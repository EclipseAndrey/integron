import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Purchase/ListCartPage/ListCartPage.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Utils/DB/Items/Product.dart';
import 'package:omega_qick/main.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  PageController controllerPage ;

  @override
  void initState() {

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
          child: Content(),
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
    for(int i = 0; i < cartList.length; i++){
      if(cartList[i].type == getCurrentPageOfList()){s++;}
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
                  child: PageView(
                    children: [
                      ListCartPage(tovar: true,),
                      ListCartPage(tovar: false,),
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
                  color: 0 == getCurrentPageOfList() ? Colors.white : c8dcde0,
                  border: Border.all(color: cDefault, width: 1)),
              child: Center(
                child: Text("Товары", style:  TextStyle(color: getCurrentPageOfList()==0 ? cMainText : Colors.white, fontWeight: FontWeight.w600, fontSize: 16, fontFamily: fontFamily ),),
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
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6)),
                  color: getCurrentPageOfList() != 0
                      ? Colors.white
                      : c8dcde0,
                  border: Border.all(color: cDefault, width: 1)),
              child: Center(
                child: Text("Услуги", style:  TextStyle(color: getCurrentPageOfList()!=0 ? cMainText : Colors.white, fontWeight: FontWeight.w600, fontSize: 16, fontFamily: fontFamily ),),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

class CartListProducts extends StatefulWidget {
  @override
  _CartListProductsState createState() => _CartListProductsState();
}

class _CartListProductsState extends State<CartListProducts> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
