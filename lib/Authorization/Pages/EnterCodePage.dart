import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:omega_qick/Authorization/auto.dart';
import 'package:omega_qick/Authorization/codeDB.dart';
import 'package:omega_qick/Authorization/finger.dart';
import 'package:omega_qick/DialogLoading/DialogLoading.dart';
import 'package:omega_qick/Login1/Login.dart';
import 'package:omega_qick/Login1/Style.dart';
import 'package:omega_qick/REST/getWalletR.dart';
import 'package:omega_qick/main.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import '../../FadeAnimation.dart';
import '../../JsonParse.dart';
import '../../balance.dart';
import '../WalletDB.dart';

class EnterCode extends StatefulWidget {
  @override
  _EnterCodeState createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {
  String text = '';
  double padding = 0;
  bool anim =false;
  void animation(){
    Future.delayed(Duration(milliseconds: 50), () {
      anim = padding== -50?false:true;
      padding = padding == 0?50:padding == 50?-50:0;

      // ignore: unnecessary_statements
      anim?animation():text ='';
      setState(() {});});

  }

  void loginFinger()async{
    bool f = await fingerDB();
    if(f){
      var auth = LocalAuthentication();
      bool didAuthenticate = await auth.authenticateWithBiometrics(
          localizedReason: 'Авторизация в приложении');
      print(didAuthenticate);
      try {

      } on PlatformException catch (e) {
        print(e);

        if (e.code == auth_error.notAvailable) {
          print(e);
        }
      }

      if(await didAuthenticate){
        print("ok");
        showDialogLoading(context);
        List<WalletData> wallets = await DBProvider.db.WalletDB();
        User user = await getUser(wallets[0].address, context);
        closeDialog(context);

        Navigator.push(context, MaterialPageRoute(builder: (context) => PageBalance()));
      }else{

      }
    }
  }
  @override
  void initState() {
    loginFinger();
  }

  void _onKeyboardTap(String value)async {
    setState(() {
      text = text + value;
    });
    if(text.length == 4){

      if(text == '4116'){
        autoDB(a: false);
        await DBProvider.db.DeleteWallets();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Splash()));

      }

      var code = await codeDB();
      if(code == 0){
        print("err code");
        animation();
      }else
      if(code == int.parse(text)){
        print("ok");
        showDialogLoading(context);
        List<WalletData> wallets = await DBProvider.db.WalletDB();
        User user = await getUser(wallets[0].address, context);
        closeDialog(context);


        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            PageBalance()), (Route<dynamic> route) => false);
      }else{
        animation();
      }
    }
    setState(() {

    });
  }

  Widget numberWidget(int position) {
    Color color ;
    try{
      color = text[position] == null?Colors.transparent:Colors.white;
    }catch(e){
      color = Colors.transparent;
    }

    try {
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0),
            color: color,

            borderRadius: const BorderRadius.all(Radius.circular(30))
        ),
        child: Center(child: Text(
          "", style: TextStyle(color: Colors.white),)),
      );
    } catch (e) {
      return Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.redAccent, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(30))
        ),
      );
    }
  }



  double spase = 18;

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: backgroundGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            )),

        child: Column
          (
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Код для входа", style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "MPLUS",),),
                      SizedBox(height: 30,),

                      Container(
                        constraints: const BoxConstraints(
                            maxWidth: 500
                        ),
                        child: AnimatedPadding(
                          duration: Duration(milliseconds: 50),
                          padding:  EdgeInsets.only(left: padding.isNegative?38.0:padding+38, right: padding.isNegative?-padding+38:38),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              numberWidget(0),
                              SizedBox(width: spase,),
                              numberWidget(1),
                              SizedBox(width: spase,),
                              numberWidget(2),
                              SizedBox(width: spase,),
                              numberWidget(3),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),

            SizedBox(height: 10,),
            NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              textColor: Colors.white,
              rightIcon: Icon(
                Icons.backspace,
                color: Colors.white,
              ),
              rightButtonFn: () {
                setState(() {
                  text = text.substring(0, text.length - 1);
                });
              },
            ),
            SizedBox(height: 20,),


          ],
        ),
      ),
    );
  }
}

