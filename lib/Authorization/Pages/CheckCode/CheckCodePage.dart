import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:omega_qick/Authorization/Pages/PageNum2/Style.dart';
import 'package:omega_qick/Authorization/auto.dart';
import 'package:omega_qick/Authorization/tokenDB.dart';
import 'package:omega_qick/AutoRoutes.dart';
import 'package:omega_qick/FadeAnimation.dart';
import 'package:omega_qick/Parse/CheckCode.dart';
import 'package:omega_qick/REST/Autorization/getCheckCode.dart';
import 'package:omega_qick/Style.dart';

class CheckCodePage extends StatefulWidget {
  String num;
  CheckCodePage(this.num);
  @override
  _CheckCodePageState createState() => _CheckCodePageState();
}

class _CheckCodePageState extends State<CheckCodePage> {
  bool check = true;
  String title = "Проверка кода";
  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      if(text.length <4)text = text + value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: homeBackgroundGradient[0],
        accentColor: homeBackgroundGradient[0],

        // Define the default font family.
        fontFamily: 'MPLUS',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(
              fontSize: 18.0, fontFamily: 'Medium', color: Colors.white),
        ),

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: backgroundGradient[0],
          shadowColor: backgroundGradient[0],
          elevation: 0,
        ),
        body: Content(),
      ),
    );
  }

  Widget Content() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Stack(


          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeAnimation(
                      1,
                      Text(
                        title,
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    1.3,
                    Text(
                      "Введите код подтверждения",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),

                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.center,
            //
            //   child:
            // ),


            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
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
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () async {
                      CheckCode response =await  CheckCodeR(widget.num, text);
                      if(response.code == 200){
                        print("CheckCodePage response token ${response.token}");
                        await tokenDB(token: response.token);
                        await autoDB(a: true);
                        AutoRoutes(context);
                      }else{
                        Fluttertoast.showToast(
                            msg: "Неверный код",
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
                          color: Colors.purple
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
                    textColor: Colors.white,
                    rightIcon: Icon(
                      Icons.backspace,
                      color: Colors.white,
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

          ],
        ),
      ),
    );
  }

  Widget numberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
          style: TextStyle(color: Colors.white),
        )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }
}
