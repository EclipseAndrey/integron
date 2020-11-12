import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/DB/auto.dart';
import 'package:omega_qick/Pages/Login2/Logo.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Pages/Welcome/Welcome.dart';

import 'package:omega_qick/Parse/CheckCode.dart';
import 'package:omega_qick/REST/Autorization/getCheckCode.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';


import '../../AutoRoutes.dart';
import '../../Utils/fun/FadeAnimation.dart';
import 'CheckText.dart';

class CheckCodePage extends StatefulWidget {
  String num;
  CheckCodePage(this.num);

  @override
  _CheckCodeState createState() => _CheckCodeState();
}

class _CheckCodeState extends State<CheckCodePage> {

  String title = "Проверка кода";
  String text = '';
  bool check = true;


  bool logo = true;
  double divBefore = 40; //40 20
  double divAfter = 20; //20 5
  double sizedAfterTool = 50; //50 0
  double minusIconSize = 0; // 0 10
  double minusFontsSize = 0; // 0 4
  double marginnTop = 30;

  void _onKeyboardTap(String value) {
    setState(() {
      if(text.length <4)text = text + value;
    });
  }


  Widget numberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(
          text[position], style: TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
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
    }
    if(shortestSide >= 400 && shortestSide <= 420){
      divBefore = 40; //40 20
      divAfter = 5; //20 5
      sizedAfterTool = 0; //50 0
      minusIconSize = 10; // 0 10
      minusFontsSize = 2; // 0 4
      logo = false;
      marginnTop = 60;
    }



    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: cBackground,
        child: Content(),
      ),
    );
  }
  Widget Content(){
    return Scaffold(
      body: SafeArea(
        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: <Widget>[
                      SizedBox(height: marginnTop,),
                      logo?Logo(context, divBefore, minusFontsSize, minusIconSize):SizedBox(),
                      SizedBox(height: sizedAfterTool,),
                      //Logo(context, divBefore, minusFontsSize, minusIconSize),

                      CheckText(context, minusFontsSize),

                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                      color: cBackground,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 500
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  numberWidget(0),
                                  numberWidget(1),
                                  numberWidget(2),
                                  numberWidget(3),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () async {
                          CheckCode response =await  CheckCodeP(widget.num, text);
                          if(response.code == "200"){
                            print("CheckCodePage response token ${response.token}");
                            await tokenDB(token: response.token);
                            await autoDB(a: true);
                            AutoRoutes(context);
                          }else if(response.code == "201"){
                            print("CheckCodePage response token ${response.token}");
                            await tokenDB(token: response.token);
                            await autoDB(a: true);
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomePage()), (route) => false);
                          }else{
                            print(response.code);
                            Fluttertoast.showToast(
                                msg: "Неверный код ${response.code}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: FadeAnimation(1.6, Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: c8dcde0
                          ),
                          child: Center(
                            child: Text("Подтвердить", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),),
                          ),
                        )),
                      ),
                      SizedBox(height: 10,),
                      NumericKeyboard(
                        onKeyboardTap: _onKeyboardTap,
                        textColor: cMainBlack,
                        rightIcon: Icon(
                          Icons.backspace,
                          color: cMainBlack,
                        ),
                        rightButtonFn: () {
                          setState(() {
                            text = text.substring(0, text.length - 1);
                          });
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
