import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/Authorization/WalletDB.dart';


import 'InputNum.dart';
import 'Strings.dart';
import 'Style.dart';

class InpNum extends StatefulWidget {
  @override
  _InpNumState createState() => _InpNumState();
}

class _InpNumState extends State<InpNum> {
  Alignment _alignment = Alignment.center;
  double x = 1;
  TextEditingController controller = TextEditingController();
  ScrollController controllerS = ScrollController();

  void animateP() {
    Future.delayed(const Duration(milliseconds: 4500), () {
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
                duration: Duration(milliseconds: 1100),
                alignment: _alignment,
                child: AnimatedContainer(
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 1100),
                  width: size.width * x,
                  height: size.width * x,
                  // padding: EdgeInsets.only(bottom: 60, right: 23),
                  child: FlareActor(
                    'lib/Animations/Eclipse1.flr',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: "go",
                  ),
                ),
              ),
              AnimatedAlign(
                duration: Duration(milliseconds: 1300),
                alignment: Alignment.bottomCenter,
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 2000),
                  padding: EdgeInsets.only(top: x == 1 ? size.width * 2 : 0),
                  child: Container(
                    color: Colors.transparent,
                    width: size.width,
                    height: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          welcomeText,
                          style: styleGeneralText,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 30),
                          child: InputNum(controller,controllerS),
                        ),

                        Text(
                          labelBetweenText,
                          style: styleBetween,
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
