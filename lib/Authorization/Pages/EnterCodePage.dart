import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/DB/auto.dart';

import 'package:omega_qick/Login1/Login.dart';
import 'package:omega_qick/Login1/Style.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/GeneralControllerPages.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/REST/getWalletR.dart';
import 'package:omega_qick/Utils/DB/WalletDB.dart';
import 'package:omega_qick/Utils/DB/codeDB.dart';
import 'package:omega_qick/Utils/DB/finger.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogLoading.dart';
import 'package:omega_qick/main.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import '../../Utils/fun/FadeAnimation.dart';
import '../../JsonParse.dart';
import '../../balance.dart';

class EnterCode extends StatefulWidget {
  @override
  _EnterCodeState createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {

  String text = '';
  double padding = 0;
  bool fingerIcon = false;
  bool anim = false;

  void initFinger()async{
    if(await fingerDB()) fingerIcon = true;
    setState(() {

    });
  }

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

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => GeneralControllerPages()), (route) => false);
      }else{

      }
    }
  }
  @override
  void initState() {
    initFinger();
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
            GeneralControllerPages()), (Route<dynamic> route) => false);
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
      color = text[position] == null?Colors.transparent:cMainBlack;
    }catch(e){
      color = Colors.transparent;
    }

    try {
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            border: Border.all(color: cMainBlack, width: 0),
            color: color,

            borderRadius: const BorderRadius.all(Radius.circular(30))
        ),
        child: Center(child: Text(
          "", style: TextStyle(color: cMainBlack),)),
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
        color: cBackground,

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
                      Text("Код для входа", style: TextStyle(color: cMainBlack, fontSize: 24, fontFamily: "MPLUS",),),
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
              textColor: cMainBlack,
              leftIcon: Icon(Icons.fingerprint, color: fingerIcon?cDefault:Colors.transparent,),
              leftButtonFn: (){
                if(fingerIcon){
                  loginFinger();
                }
              },
              rightIcon: Icon(
                Icons.backspace,
                color: cDefault,
              ),
              rightButtonFn: () {
                setState(() {
                  if(text.length>0)
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

