import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omega_qick/DialogLoading/DialogError.dart';
import 'package:omega_qick/DialogLoading/DialogLoading.dart';
import 'package:omega_qick/DialogLoading/DialogOk.dart';
import 'package:omega_qick/REST/payDelOnAddress.dart';

Widget ButtonSend(String seed,TextEditingController summ, TextEditingController address,BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 18.0, left: 28, right: 28),
    child: FlatButton(
      onPressed: () async {

        if(summ.text == "" || address.text == ""){
          showDialogError(context);
        }else{
          showDialogLoading(context);

          var e = await sendDel(seed, address.text, summ.text);


          closeDialog(context);
          showDialogOk(context);
        }




      },
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.purple),
        borderRadius: BorderRadius.circular(20),

      ),

      color: Colors.purple,
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
