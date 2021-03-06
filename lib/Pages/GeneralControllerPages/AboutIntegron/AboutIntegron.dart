import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:integron/AutoRoutes.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Pages/Login2/Logo.dart';
import 'package:integron/Style.dart';


import 'package:integron/Utils/fun/DialogLoading/DialogLoading.dart';


class AboutIntegron extends StatefulWidget {
  @override
  _AboutIntegronState createState() => _AboutIntegronState();
}

class _AboutIntegronState extends State<AboutIntegron> {

  bool logo = true;
  double divBefore = 40; //40 20
  double divAfter = 20; //20 5
  double sizedAfterTool = 50; //50 0
  double minusIconSize = 0; // 0 10
  double minusFontsSize = 0; // 0 4
  double marginnTop = 30;


  double beforeLogo= 50;
  double afterText= 50;
  double betweenText= 10;



  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle//.dark
        (
        //statusBarColor: cBackground,
        systemNavigationBarColor: Color(0x00cccccc),
        systemNavigationBarDividerColor: Color(0x00cccccc),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0xFFffffff),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    double shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);

    if(shortestSide < 400){
      logo = false;
      divBefore = 20; //40 20
      divAfter = 5; //20 5
      sizedAfterTool = 50; //50 0
      minusIconSize = 10; // 0 10
      minusFontsSize = 4; // 0 4
      marginnTop = 0;

      beforeLogo= 50;
      afterText= 50;
      betweenText= 10;


    }
    if(shortestSide >= 400 && shortestSide <= 420){
      divBefore = 40; //40 20
      divAfter = 5; //20 5
      sizedAfterTool = 0; //50 0
      minusIconSize = 0; // 0 10
      minusFontsSize = 0; // 0 4
      marginnTop = 60;


      beforeLogo= 50;
      afterText= 50;
      betweenText= 10;

    }



    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: cBG,
        child: Content2(),
      ),
    );
  }

  Widget Content(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(height: 50,),
        Column(
          children: [
            Text("Добро пожаловать\nв", textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 27, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal, fontFamily: fontFamily),),
            SizedBox(height: 6,),
            Logo(context, divBefore, minusFontsSize, minusIconSize),
            Image.asset("lib/assets/images/welcome.png",
            ),
          ],
        ),

        TextWelcome(),
        TextButtonNext(),
        SizedBox(height: 50,),

      ],
    );


  }




  Widget TextWelcome(){
    return Column(
      children: [
        Text("", style: TextStyle(color: cMainText, fontWeight: FontWeight.w400, fontSize: 27 - minusFontsSize, fontStyle: FontStyle.normal),),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text("Почему Inegron? Мы внедряем современные технологии blockchain в нашу повседневную жизнь. С помощью Integron можно мы сделаем этот мир лучше.", style: TextStyle(color: cMainText, fontWeight: FontWeight.w400, fontSize: 16 - minusFontsSize, fontStyle: FontStyle.normal),),
        ),
      ],
    );
  }



  Widget TextButtonNext(){
    return GestureDetector(
      onTap: (){
        closeDialog(context);
      },
      child: Text(
        "Назад",
        style: TextStyle(
            color: c5894bc,
            fontWeight: FontWeight.w600,
            fontSize: 16 - minusFontsSize,
            fontStyle: FontStyle.normal
        ),
      ),
    );
  }


  Widget Content2(){
    return SafeArea(child: Padding(
      padding: const EdgeInsets.all(26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButtonNext(),
          SizedBox(height: 24,),

          Text("Что такое Integron?", style: TextStyle(color: cMainText, fontStyle: FontStyle.normal, fontFamily: fontFamily, fontSize: 27, fontWeight: FontWeight.w400, ),),
          SizedBox(height: 33,),
          Text("Integron - это площадка объединяющая виртуальный и реальный мир. Integron это сообщество, которое хочет идти в ногу со временем. Мы интегрируем на нашей платформе реальные сектора бизнеса для оплаты товаров за токены. Почему Inegron? Мы внедряем современные технологии blockchain в нашу повседневную жизнь. С помощью Integron мы сделаем этот мир лучше.",
          style: TextStyle(color: cMainText, fontWeight: FontWeight.w400, fontSize: 16, fontFamily: fontFamily, fontStyle: FontStyle.normal,),),


        ],
      ),
    ));
  }


}
