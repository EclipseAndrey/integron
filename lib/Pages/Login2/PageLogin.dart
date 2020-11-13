import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


import 'ButtonNext.dart';
import 'HaveAccount.dart';
import 'IconHelp.dart';
import 'Logo.dart';
import 'PanelTools.dart';
import 'Style.dart';
import 'TextCreateAccount.dart';
import 'TextFieldNum.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerNum = TextEditingController();
  TextEditingController controllerCode = TextEditingController();

  var maskFormatter = new MaskTextInputFormatter(mask: '(###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });
  bool active = false;





  @override
  Widget build(BuildContext context) {



    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: cBG,
        child: Content(),
      ),
    );
  }
  Widget Content (){
    print("h ${ MediaQuery.of(context).size.height} w ${MediaQuery.of(context).size.width} ");

    double divBefore = 40; //40 20
    double divAfter = 20; //20 5
    double sizedAfterTool = 50; //50 0
    double minusIconSize = 0; // 0 10
    double minusFontsSize = 0; // 0 4

    double shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);

    if(shortestSide < 400){
      divBefore = 20; //40 20
      divAfter = 5; //20 5
      sizedAfterTool = 0; //50 0
      minusIconSize = 10; // 0 10
      minusFontsSize = 4; // 0 4
    }

    if(shortestSide >= 400 && shortestSide <= 420){
      divBefore = 20; //40 20
      divAfter = 5; //20 5
      sizedAfterTool = 0; //50 0
      minusIconSize = 10; // 0 10
      minusFontsSize = 2; // 0 4
    }

    controllerNum.addListener(() {
      print(maskFormatter.getUnmaskedText().length);
      if (maskFormatter.getUnmaskedText().length != 10) {
        setState(() {
          active = false;

        });
      } else {
        active = true;
        setState(() {

        });
      }
    });




    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 38.0, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HaveAccount(context, minusFontsSize),
              IconHelp(context),
            ],
          ),
        ),
        SizedBox(height:  20,),
        Logo(context, divBefore, minusFontsSize, minusIconSize-6),
        SizedBox(height: divAfter,),

        TextCreateAccount(context, minusFontsSize),
        SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38.0),
          child: Column(
            children: [
              TextFieldNum(context, controllerNum,maskFormatter, minusFontsSize, ),
              SizedBox(height: 10,),
              Container(
                  height: 55,
                  child: ButtonNext(context, controllerNum, maskFormatter, active))
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38.0),
          child: PanelTools(context, minusIconSize),
        ),
        SizedBox(height: sizedAfterTool),

        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text("Пользовательского соглашения", style: TextStyle(color: c5894bc, fontSize:  14, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, ),),
        ),
      ],
    );
  }
}
