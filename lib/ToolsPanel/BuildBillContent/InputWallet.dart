
import 'package:flutter/material.dart';
import 'package:omega_qick/QrLib/QrScanner/QrScannerController.dart';

import 'Strings.dart';

Widget InputWallet(TextEditingController controller){
  return Padding(
    padding:  EdgeInsets.only(top: 18.0, left: 8, right: 8),
    child: TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      keyboardType: TextInputType.text,

      controller: controller,
      decoration:  InputDecoration(
          suffixIcon: IconButton(

            icon: GestureDetector(
                onTap: ()async{
                  var qrRes  = await QrScan();
                  controller.text = qrRes.rawContent;
                },
                child: Icon(Icons.center_focus_weak, color: Colors.white70,)),
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
          hintText: hintTextWallet,
          hintStyle: TextStyle(color: Colors.white54)
      ),
    ),
  );
}