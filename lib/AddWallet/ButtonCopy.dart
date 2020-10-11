import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Strings.dart';
import 'Style.dart';



class ButtonCopy extends StatefulWidget {
  String seed;
  ButtonCopy(this.seed);
  @override
  _ButtonCopyState createState() => _ButtonCopyState(seed);
}

class _ButtonCopyState extends State<ButtonCopy> {

  String seed;
  _ButtonCopyState(this.seed);

  bool copy = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: FlatButton(
        onPressed: () async {
          Clipboard.setData( ClipboardData(text: seed));
          try{
            copy = true;
            setState(() {
            });
          }catch(e){}




        },
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),

        ),

        color: colorButton,
        textColor: colorTapButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(copy?"Скопировано":buttonCopyText, style: styleButtonText,),
            ),

          ],
        ),
      ),
    );
  }
}
