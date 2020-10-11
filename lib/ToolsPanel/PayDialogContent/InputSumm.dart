
import 'package:flutter/material.dart';
import 'package:omega_qick/Head/Colors.dart';
import 'package:omega_qick/Head/Const.dart';

Widget InputSumm(TextEditingController controller, String max){
  return Padding(
    padding:  EdgeInsets.only(top: 18.0, left: 8, right: 8),
    child: TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      keyboardType: TextInputType.number,

      controller: controller,
      decoration:  InputDecoration(
          suffixIcon: IconButton(
            onPressed: (){
              controller.text = (double.parse(max)-0.5).toString();
              controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));

            },


            icon: Icon(Icons.attach_money, color: Colors.white70,),

            color: Colors.white70,
          ),


          border:  OutlineInputBorder(
            borderRadius:  BorderRadius.circular(25.0),
            borderSide:  BorderSide(color: Colors.pink),

          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.purple,
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
              color: Colors.purpleAccent,
              width: 2.0,
            ),
          ),

          // focusedBorder: InputBorder.none,
          // errorBorder: InputBorder.none,
          // disabledBorder: InputBorder.none,
          contentPadding:
          EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: "Сумма перевода",
          hintStyle: TextStyle(color: Colors.white54)
      ),
    ),
  );
}