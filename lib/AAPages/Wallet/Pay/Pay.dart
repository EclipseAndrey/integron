import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/fun/InitSum.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'PayDialogContent/ButtonSend.dart';
import 'PayDialogContent/InputSumm.dart';
import 'PayDialogContent/InputWallet.dart';

void pyaDialog(BuildContext context1, String seed, String max) {
  showBarModalBottomSheet(
    context: context1,
    builder: (context, scrollController) => PayContent(seed, max),
  );
}

class PayContent extends StatefulWidget {
  String seed, max;

  PayContent(this.seed, this.max);

  @override
  _PayContentState createState() => _PayContentState(seed, max);
}

TextEditingController controllerSumm = TextEditingController();
TextEditingController controllerAdress = TextEditingController();

class _PayContentState extends State<PayContent> {


  String seed, max;

  _PayContentState(this.seed, this.max);



  @override
  void initState() {
    controllerSumm.addListener(() {
      if(controllerSumm.text.length >0 && !InitSum.checkSumm(controllerSumm.text)){
        controllerSumm.text = controllerSumm.text.substring(0,controllerSumm.text.length-1);
        controllerSumm.selection = TextSelection.fromPosition(TextPosition(offset: controllerSumm.text.length));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controllerSumm.text = "";
    controllerAdress.text = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Material(
        child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: cBackgroundGradient)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Перевод",
                          style: TextStyle(
                              fontFamily: "MPLUS",
                              color: cMainText,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  InputWallet(controllerAdress),
                  InputSumm(controllerSumm, max),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Комиссия: 0.342 DEL",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  ButtonSend(seed, controllerSumm, controllerAdress, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
