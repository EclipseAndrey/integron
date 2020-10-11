import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:omega_qick/Authorization/WalletDB.dart';
import 'package:omega_qick/Authorization/codeDB.dart';
import 'package:omega_qick/LogFile.dart';
import 'package:omega_qick/Login1/Login.dart';
import 'package:omega_qick/Login1/Style.dart';
import 'package:local_auth/local_auth.dart';
import 'package:omega_qick/REST/getWalletR.dart';
import '../../FadeAnimation.dart';
import '../../JsonParse.dart';
import '../../balance.dart';
import '../auto.dart';
import 'DoYouWantSetFinger.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class SetCode extends StatefulWidget {
  @override
  _SetCodeState createState() => _SetCodeState();
}
int code = 0;




class _SetCodeState extends State<SetCode> {
  String text = '';
  int timer = 0;
  bool set = true;

  void _onKeyboardTap(String value)async {
    setState(() {
      text = text + value;
    });
    if(text.length == 4){

      code = set?int.parse(text):code;

      if(!set){
        if(timer == 3){
         set = true;
         print("set t");
         text = '';
         timer = 0;
         setState(() {});
        }else{
          if(code == 0){
            print("err code");
            set = true;
            print("set t");

            text = '';
            setState(() {});
          }else
          if(code == int.parse(text)){

            print("ok $code , $text");
            codeDB(code: code);
            var localAuth = LocalAuthentication();
            // ignore: unnecessary_statements
            if(await localAuth.canCheckBiometrics){
              print(await localAuth.canCheckBiometrics);
              await showDialogWantFinger(context);
              writeLog("Сканер найден, диалог закрыт");

              print("scan close");
            }else{
              writeLog("Сканер отпечатка не найден ");
              print("no  scan");
            }
            List<WalletData> wallets = await DBProvider.db.WalletDB();
            User user = await getUser(wallets[0].address, context);
            if(user != null)autoDB(a: true);else{
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            }
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PageBalance(user , wallets[0].seed)));

            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                PageBalance()), (Route<dynamic> route) => false);

            //OK
          }else{
            timer++;
            text = "";
          }
        }
      }else{
        set = false;
        print("set f");
        text = '';
        setState(() {

        });

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
                      Text(set?"Придумайте код для входа":"Повторите код", style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "MPLUS",),),
                      SizedBox(height: 30,),

                      Container(
                        constraints: const BoxConstraints(
                            maxWidth: 500
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 38.0, right: 38),
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

