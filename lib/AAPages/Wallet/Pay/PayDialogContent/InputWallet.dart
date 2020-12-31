
import 'package:flutter/material.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/fun/QrLib/QrScanner/QrScannerController.dart';

Widget InputWallet(TextEditingController controller){
  return Padding(
    padding:  EdgeInsets.only(top: 18.0, left: 8, right: 8),
    child: TextFormField(
      style: TextStyle(
        color: cMainText,
      ),
      cursorColor: cMainText,
      keyboardType: TextInputType.text,
      controller: controller,

      decoration:  InputDecoration(
          suffixIcon: GestureDetector(
              onTap: ()async{
                    var qrRes  = await QrScan();
                    controller.text = qrRes.rawContent;
              },
              child: Icon(Icons.center_focus_weak, color: cMainText.withOpacity(0.7), )),
          // IconButton(
          //
          //   icon: IconButton(icon: , color: Colors.white70, onPressed: ()async {
          //     var qrRes  = await QrScan();
          //     controller.text = qrRes.rawContent;
          //   },),
          //   color: Colors.white70,
          // ),


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
          hintText: "Адрес кошелька",
          hintStyle: TextStyle(color: cDefault)
      ),
    ),
  );
}