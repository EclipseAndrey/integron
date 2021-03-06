import 'package:flutter/material.dart';
import 'package:integron/AutoRoutes.dart';

import 'package:integron/Pages/Login2/Logo.dart';
import 'package:integron/Style.dart';



class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

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
        child: Content(),
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
            Logo(context, divBefore, minusFontsSize, minusIconSize),
            Image.asset("lib/assets/images/welcome.png"),
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
        Text("Поздравляем!", style: TextStyle(color: cMainText, fontWeight: FontWeight.w400, fontSize: 27 - minusFontsSize, fontStyle: FontStyle.normal),),
        SizedBox(height: 10,),
        Text("Вы успешно зарегистрированы", style: TextStyle(color: cMainText, fontWeight: FontWeight.w400, fontSize: 14 - minusFontsSize, fontStyle: FontStyle.normal),),
      ],
    );
  }

  Widget TextButtonNext(){
    return GestureDetector(
      onTap: (){
        AutoRoutes(context);
      },
      child: Text(
        "Продолжить",
        style: TextStyle(
          color: c5894bc,
          fontWeight: FontWeight.w600,
          fontSize: 16 - minusFontsSize,
          fontStyle: FontStyle.normal
        ),
      ),
    );
  }
}
