import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:local_auth/local_auth.dart';
import 'package:omega_qick/AAPages/ControllerPages.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/Utils/DB/codeDB.dart';
import 'package:omega_qick/Utils/DB/auto.dart';
import 'package:omega_qick/Utils/fun/DoYouWantSetFinger.dart';

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
              print("Сканер найден, диалог закрыт");

              print("scan close");
            }else{
              print("Сканер отпечатка не найден ");
              print("no scan");
            }
            await autoDB(a: true);

            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                GeneralControllerPages()), (Route<dynamic> route) => false);

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
      color = text[position] == null?Colors.transparent:cMainText;
    }catch(e){
      color = Colors.transparent;
    }

    try {
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            border: Border.all(color: cMainText, width: 0),
            color: color,

            borderRadius: const BorderRadius.all(Radius.circular(30))
        ),
        child: Center(child: Text(
          "", style: TextStyle(color: cMainText),)),
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
        color: cBG,

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
                      Text(set?"Уникальный ПИН-код":"Повторите ПИН-код", style: TextStyle(color: cMainText, fontSize: 24, fontFamily: "MPLUS",),),
                      SizedBox(height: 30,),
                      Text(set?"Придумайте уникальный код,":"Запомните ПИН-код и никому его", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600,  ),),
                      Text(set?"с помощью которого вы будете входить":"не сообщайте", style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600,  ),),
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
              textColor: cMainText,
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

