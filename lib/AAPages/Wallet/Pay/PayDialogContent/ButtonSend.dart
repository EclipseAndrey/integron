import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:integron/Providers/WalletProvider/WalletProvider.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:integron/Utils/fun/DialogLoading/DialogLoading.dart';
import 'package:integron/Utils/fun/DialogLoading/DialogOk.dart';
import 'package:integron/Utils/fun/DialogsIntegron/DialogIntegron.dart';
import 'package:integron/Utils/fun/InitSum.dart';



Widget ButtonSend(String seed,TextEditingController summ, TextEditingController address,BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 18.0, left: 28, right: 28),
    child: FlatButton(
      onPressed: () async {

        if(summ.text == "" || address.text == ""){
          showDialogIntegronError(context, "Адрес получателя или сумма не указаны");
        }else{
          showDialogLoading(context);

          Put response = await WalletProvider.sendDel(address.text,InitSum.initSumReplace(summ.text));
          closeDialog(context);

          if(response.error == 200){
            closeDialog(context);
            showDialogOk(context);
          }else{
            showDialogIntegronError(context, response.mess);
          }

          //showDialogOk(context);
        }




      },
      shape: RoundedRectangleBorder(
        side: BorderSide(color: cButtons),
        borderRadius: BorderRadius.circular(20),

      ),

      color: cButtons,
      textColor: Colors.purpleAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text("Отправить", style: TextStyle(fontFamily: "MPLUS", color: Colors.white, fontSize: 18),),
          ),
        ],
      ),
    ),
  );
}
