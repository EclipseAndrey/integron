import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:integron/Style.dart';



Widget TextFieldNum(BuildContext context, TextEditingController controller, MaskTextInputFormatter maskFormatter,  double minusFontsSize){

  return Theme(
    data: ThemeData(
      primarySwatch: Colors.blue
    ),
    child: TextField(
      controller:  controller,
      inputFormatters: [maskFormatter],
      keyboardType: TextInputType.number,
      style: TextStyle(

        color: cMainText,
        fontSize: 18 - minusFontsSize,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        prefix: Text('+7 '),
        filled: true,
        hintText: "(900) 000-00-00",
        hintStyle: TextStyle(color:Colors.black45, fontSize: 18 - minusFontsSize, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),

        ),
      ),
    ),
  );
}