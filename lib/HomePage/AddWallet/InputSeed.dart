import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:omega_qick/JsonParse.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/fun/LogFile.dart';
import 'package:omega_qick/Login1/Style.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/REST/getAddress.dart';
import 'package:omega_qick/REST/getWalletR.dart';

Widget InputSeed(TextEditingController controller, BuildContext context){



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
              onPressed: ()async{
                Clipboard.getData('text/plain').then((clipboarContent) {
                  print('Clipboard content ${clipboarContent.text}');
                  controller.text = clipboarContent.text;
                  controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
                });
              },
              icon: iconSeed,

            // onPressed: ()async{
            //   if(controller.text != ""){
            //     showDialogLoading(context);
            //     String seed = controller.text;
            //
            //     RegExp exp = RegExp(r"[^a-z A-Z]+");
            //     seed = seed.replaceAll(exp, '');
            //     AddressA address = await getAddress(seed, context);
            //
            //     writeLog(seed);
            //     User user = await getUser(address.address, context);
            //     if(user == null||address == null){
            //       Fluttertoast.showToast(
            //           msg: "Соединение не установлено",
            //           toastLength: Toast.LENGTH_SHORT,
            //           gravity: ToastGravity.BOTTOM,
            //           timeInSecForIosWeb: 1,
            //           backgroundColor: Colors.black,
            //           textColor: Colors.white,
            //           fontSize: 16.0
            //       );
            //       closeDialog(context);
            //       Navigator.pop(context);
            //     }else{
            //
            //       WalletData wallet = WalletData(seed,user.result.address.address);
            //       await DBProvider.db.WalletDB(walletData: wallet);
            //       closeDialog(context);
            //       Navigator.pop(context);
            //     }
            //   }
            // },


            //icon: Icon(Icons.add_circle_outline, color: controller.text == ""? Colors.transparent:Colors.white70,),

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
          hintText: "Добавить по сид фразе",
          hintStyle: TextStyle(color: Colors.white54)
      ),
    ),
  );
}