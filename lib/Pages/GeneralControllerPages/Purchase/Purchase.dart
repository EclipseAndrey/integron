import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/AAPages/Blocs/Cart/CartCubit.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/GeneralControllerPages/Purchase/ListCartPage/ListCartPage.dart';
import 'package:integron/Style.dart';
import 'package:integron/main.dart';

class Cart extends StatefulWidget {
  BuildContext contextBloc;
  Cart(this.contextBloc);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  PageController controllerPage ;

  @override
  void initState() {
    controllerPage = PageController(initialPage: 0);
    controllerPage.addListener(() {setState(() {});});
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
          child: Content(),
        ),
      ),
    );
  }

  int getCurrentPageOfList(){
   try {
     return controllerPage.page.round();
   }catch(e){
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
              //HeaderCart(),
              Container(
                  height: MediaQuery.of(context).size.height - 80,
                  width: MediaQuery.of(context).size.width,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // BlocBuilder<CartCubit,CartState>(
                      //     builder: (context, state){
                      //       if(state is CartLoading){
                      //         return Center(child: CircularProgressIndicator(),);
                      //       }else if(state is CartComplete){
                      //         return ListCartPageW(state, widget.contextBloc, true);
                      //       }else{
                      //         return Center();//todo err
                      //       }
                      //     }),
                      // BlocBuilder<CartCubit,CartState>(
                      //     builder: (context, state){
                      //       if(state is CartLoading){
                      //         return Center(child: CircularProgressIndicator(),);
                      //       }else if(state is CartComplete){
                      //         return ListCartPageW(state, widget.contextBloc, false);
                      //       }else{
                      //         return Center();//todo err
                      //       }
                      //     }),
                      ListCartPage(tovar: true),
                      ListCartPage(tovar: false),
                    ],
                    controller: controllerPage,
                  ),
              ),
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
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6)),
                  color: getCurrentPageOfList() != 0
                      ? c8dcde0: Colors.white,
                  border: Border.all(color: cDefault, width: 1)),
              child: Center(
                child: Text("Услуги", style:  TextStyle(color: getCurrentPageOfList()!=0 ?  Colors.white: cMainText, fontWeight: FontWeight.w600, fontSize: 16, fontFamily: fontFamily ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

