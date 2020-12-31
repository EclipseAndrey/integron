import 'package:flutter/material.dart';
import 'package:integron/Style.dart';


Widget InputSumm(TextEditingController controller, String max){
  return Padding(
    padding:  EdgeInsets.only(top: 18.0, left: 8, right: 8),
    child: TextFormField(
      style: TextStyle(
        color: cMainText,
      ),
      cursorColor: cMainText,
      keyboardType: TextInputType.number,

      controller: controller,
      decoration:  InputDecoration(
          suffixIcon: IconButton(
            onPressed: (){
              controller.text = (double.parse(max)-0.5).toString();
              controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));

            },


            icon: Icon(Icons.attach_money, color: cDefault,),

            color: Colors.white,
          ),


          border:  OutlineInputBorder(
            borderRadius:  BorderRadius.circular(25.0),
            borderSide:  BorderSide(color: cMainText.withOpacity(0.8)),

          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: cDefault,
              width: 2.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: cMainText.withOpacity(0.8),
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: cMainText.withOpacity(0.8),
              width: 2.0,
            ),
          ),

          // focusedBorder: InputBorder.none,
          // errorBorder: InputBorder.none,
          // disabledBorder: InputBorder.none,
          contentPadding:
          EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: "Сумма перевода",
          hintStyle: TextStyle(color: cDefault)
      ),
    ),
  );
}