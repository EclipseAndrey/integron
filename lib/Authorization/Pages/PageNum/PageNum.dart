import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:omega_qick/FadeAnimation.dart';
import 'package:omega_qick/Style.dart';

class PageNum extends StatefulWidget {
  @override
  _PageNumState createState() => _PageNumState();
}

class _PageNumState extends State<PageNum> {
  var maskFormatter = new MaskTextInputFormatter(
      mask: '(###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  void next() {}

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
          backgroundColor: Color.fromRGBO(32, 38, 45, 1),
          shadowColor: Colors.transparent,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: homeBackgroundGradient,
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 60,),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "Вход",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          1.3,
                          Text(
                            "Добро пожаловать",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: inpitNum(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inpitNum() {
    return FadeAnimation(
        1.4,
        Container(
          decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(34, 15, 45, .3),
                    blurRadius: 20,
                    offset: Offset(0, 10))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.transparent))),
                child: TextField(
                  style: TextStyle(color: Colors.white70),
                  cursorColor: Colors.white,

                  keyboardType: TextInputType.number,
                  inputFormatters: [maskFormatter],
                  decoration: InputDecoration(

                      prefix: Text('+7 '),
                      hintText: "Номер телефона",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
        ));
  }
}
