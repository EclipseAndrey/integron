import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:omega_qick/AddWallet/AddWalletPage.dart';
import 'package:omega_qick/main.dart';
import 'ButtonLogin.dart';
import 'Strings.dart';
import 'Style.dart';

class InputNum extends StatefulWidget {
  TextEditingController controller;
  ScrollController controller1;
  InputNum(this.controller, this.controller1);

  @override
  _InputNumState createState() => _InputNumState(this.controller, controller1);
}

double h = 0;

class _InputNumState extends State<InputNum> {
  var maskFormatter = new MaskTextInputFormatter(mask: '(###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });
  TextEditingController controller;
  ScrollController controller1;

  _InputNumState(this.controller, this.controller1);

  @override
  Widget build(BuildContext context) {

    controller.addListener(() {
      print("editing");

      if(controller.text == "add"){
        controller.text = "";
      }

      if (maskFormatter.getUnmaskedText().length != 10) {
        setState(() {
          h = 0;

        });
      } else {
        h = 50;
        setState(() {

        });
      }
    });

    return Padding(
      padding: EdgeInsets.only(top: 18.0, left: 8, right: 8),
      child: Column(
        children: [
          TextFormField(
            inputFormatters: [maskFormatter],
            controller: controller,
            style: TextStyle(color: Colors.white70),
            cursorColor: cursorColor,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                prefix: Text('+7 '),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: colorBorderSideOutSeed,
                    width: 2.0,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.pink,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: colorBorderSideActiveSeed,
                    width: 2.0,
                  ),
                ),

                // focusedBorder: InputBorder.none,
                // errorBorder: InputBorder.none,
                // disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: hintTextSeedText,
                hintStyle: hintTextSeed),
          ),
          Padding(
            padding:  EdgeInsets.only(top: h/2),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              height: h,
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28),
                child: ButtonLogin(context,"7"+maskFormatter.getUnmaskedText()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
