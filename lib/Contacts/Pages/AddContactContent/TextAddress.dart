 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/QrLib/QrScanner/QrScannerController.dart';

Widget body(TextEditingController addressController, TextEditingController nameController, TextEditingController numController, ){

  Widget input(TextEditingController controller, String hint){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(

        decoration: InputDecoration(
          suffixIcon: hint == "Address"?GestureDetector(
              onTap: ()async{
                var qrRes  = await QrScan();
                controller.text = qrRes.rawContent;
              },
              child: Icon(Icons.center_focus_weak, color: Colors.white70, )):SizedBox(),


          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(
          //       color: Colors.white,
          //       width: 1.0,
          //       style: BorderStyle.none
          //   ),
          // ),
          focusedBorder: new UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            ),
          ),
          disabledBorder: new UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            ),
          ),
          // focusedErrorBorder:new UnderlineInputBorder(
          //   borderSide: BorderSide(
          //       color: Colors.white
          //   ),
          // ),



          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white38,
          ),
        ),
        controller: controller,

      ),
    );
  }


  return Padding(
    padding: const EdgeInsets.only(left: 18.0, right: 18),
    child: Column(
      children: [
        input(nameController, "Name"),
        input(addressController, "Address"),
        input(numController, "Number"),
      ],
    ),
  );



}