import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/DialogLoading/DialogLoading.dart';
import 'package:omega_qick/DialogLoading/DialogOk.dart';
import 'package:omega_qick/InitBalance.dart';
import 'package:omega_qick/JsonParse.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/REST/payDelOnAddress.dart';

import 'Style.dart';

Widget buttonSendDel(List<AddressA> addresses, User wallet, User walletZ, BuildContext context, TextEditingController controller){

  AddressA FindAddress(List<AddressA> addresses, User wallet) {
    for (int i = 0; i < addresses.length; i++) {
      if (addresses[i].address == wallet.result.address.address)
        return addresses[i];
    }
  }

  return Padding(
    padding: const EdgeInsets.only(top: 18.0, left: 28, right: 28),
    child: FlatButton(
      onPressed: ()async {
        if(walletZ == null || wallet == null){
          Fluttertoast.showToast(
              msg: "Укажите счет",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }else
        if(controller.text ==""){
          Fluttertoast.showToast(
              msg: "Сумма не указана",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }else if (double.parse(controller.text)<double.parse(InitBalace(wallet.result.address.balance.del))) {
          showDialogLoading(context);

          var e = await sendDel(FindAddress(addresses, wallet).mnemonic, walletZ.result.address.address, controller.text);


          closeDialog(context);
          closeDialog(context);
          showDialogOk(context);
        }


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
            child: Text("Перевести", style: styleButtonText,),
          ),
        ],
      ),
    ),
  );
}