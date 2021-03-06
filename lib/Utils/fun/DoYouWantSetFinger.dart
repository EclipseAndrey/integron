import 'dart:io';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/finger.dart';
import 'package:integron/Utils/fun/DialogLoading/DialogLoading.dart';

Future<bool>showDialogWantFinger(BuildContext context)async{

  var auth = LocalAuthentication();

  String text ='Хотите входить с Touch ID?';

  if (Platform.isIOS) {
    print("Платформа IOS");
    List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();

    if (availableBiometrics.contains(BiometricType.face)) {
      text = "Хотите входить с Fce ID?";
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      text = "Хотите входить с Touch ID?";
    }
  }

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: cBG,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)
            ),

          ),
          width: 0,
          height: 130,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(text, style: TextStyle(color: cMainText, fontSize: 18),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      color: Colors.transparent,
                      onPressed: () {
                        print("Отмена установки отпечатка");
                        closeDialog(context);
                        fingerDB(f: false);

                      },
                      child: Text("Нет", style: TextStyle(color: cMainText, fontSize: 18),),
                    ),
                    FlatButton(
                      color: Colors.transparent,
                      onPressed: ()async {
                        print("Вызвано окно подтвержения отпечатка");
                        print("press");
                        bool didAuthenticate = await auth.authenticateWithBiometrics(
                            localizedReason: 'Подтвердите');
                        print(didAuthenticate);
                        try {
                          print("Отпечаток сработал успешно");
                        } on PlatformException catch (e) {
                          print(e);

                          if (e.code == auth_error.notAvailable) {
                            print(e);
                            print(e.toString());
                          }
                        }
                        if(await didAuthenticate){
                          print("Подвержден отпечаток");
                          fingerDB(f: true);
                          closeDialog(context);
                        }else{
                          print("Не подвержден отпечаток, закрытие окна");

                          fingerDB(f: false);
                          closeDialog(context);
                        }
                      },
                      child: Text("Да", style: TextStyle(color: cMainBlack, fontSize: 18),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
  return true;
}