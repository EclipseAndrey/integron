import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:omega_qick/Login1/Strings.dart';
import 'package:omega_qick/Login1/Style.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/REST/getAddress.dart';
import 'package:omega_qick/REST/getWalletR.dart';
import 'package:omega_qick/Utils/DB/WalletDB.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogLoading.dart';

import '../../JsonParse.dart';
import '../../Utils/fun/LogFile.dart';


Widget ButtonGenerate(BuildContext context, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(top: 18.0, left: 28, right: 28),
    child: FlatButton(
      onPressed: () async {
        if(controller.text != ""){
          showDialogLoading(context);
          String seed = controller.text;

          RegExp exp = RegExp(r"[^a-z A-Z]+");
          seed = seed.replaceAll(exp, '');
          AddressA address = await getAddress(seed, context);


          User user = await getUser(address.address, context);
          if(user == null||address == null){
            Fluttertoast.showToast(
                msg: "Соединение не установлено",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
            closeDialog(context);
            Navigator.pop(context);
          }else{

            WalletData wallet = WalletData(seed,user.result.address.address);
            await DBProvider.db.WalletDB(walletData: wallet);
            closeDialog(context);
            Navigator.pop(context);
          }
        }else
        Navigator.of(context).pushNamed('/AddWallet/AddWalletPage');

      },
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorBorderSideButton),
        borderRadius: BorderRadius.circular(30),

      ),

      color: colorButton,
      textColor: colorTapButton,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(controller.text == ""?buttonGenerateText1:buttonGenerateText2, style: styleButtonText,),
          ),
        ],
      ),
    ),
  );
}