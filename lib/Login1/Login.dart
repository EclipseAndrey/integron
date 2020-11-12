import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'package:omega_qick/Utils/DB/WalletDB.dart';

import 'ButtonGenerate.dart';
import 'InputSeed.dart';
import 'Strings.dart';
import 'Style.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Alignment _alignment = Alignment.center;
  double x = 1;
  TextEditingController controller = TextEditingController();
  ScrollController controllerS = ScrollController();

  void animateP() {
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        _alignment = Alignment.topCenter;
        x = 0.80;
      });
    });
  }

  @override
  void initState() {
    DBProvider.db.DeleteWallets();
    animateP();
  }

  @override
  Widget build(BuildContext context) {

    controllerS.addListener(() {
      print(controllerS.offset);
    });
    controller.addListener(() {
      if(controller.text == ""){
        controllerS.jumpTo(30.0);
      }else{
        controllerS.jumpTo(120.0);
        setState(() {

        });

      }
    });

    var size = MediaQuery.of(context).size;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      primary: false,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding:false,
      body: SingleChildScrollView(
        controller: controllerS,
        child: Container(
          padding: EdgeInsets.all(0),
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: backgroundGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: [
              AnimatedAlign(
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 0),
                alignment: _alignment,
                child: AnimatedContainer(
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 0),
                  width: size.width * x,
                  height: size.width * x,
                  // padding: EdgeInsets.only(bottom: 60, right: 23),

                ),
              ),
              AnimatedAlign(
                duration: Duration(milliseconds: 0),
                alignment: Alignment.center,
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 0),
                  padding: EdgeInsets.only(top: x == 1 ? size.width * 2 : 0),
                  child: Container(
                    color: Colors.transparent,
                    width: size.width,
                    height: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50,),
                        Text(
                          welcomeText,
                          style: styleGeneralText,
                        ),
                        SizedBox(height: 38,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:8.0),
                          child: Text(
                            "Давайте добавим кошелек",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "MPLUS",
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: InputSeed(controller,controllerS),
                        ),

                        Text(
                          labelBetweenText,
                          style: styleBetween,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ButtonGenerate(context,controller),
                        ),
                      ],

                    ),
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
