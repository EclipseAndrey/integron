import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:integron/main.dart';
import 'package:local_auth/local_auth.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:integron/AAPages/ControllerPages.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/codeDB.dart';
import 'package:integron/Utils/DB/finger.dart';
import 'package:local_auth/error_codes.dart' as auth_error;


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

  void loginFinger({bool delay})async{
    if(delay??false) await Future.delayed(Duration(seconds: 1));

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
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => GeneralControllerPages()), (route) => false);
      }else{

      }
    }
  }
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle//.dark
        (
        //statusBarColor: cBackground,
        systemNavigationBarColor: Color(0x00cccccc),
        systemNavigationBarDividerColor: Color(0x00cccccc),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0xFFffffff),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    initFinger();
    loginFinger(delay: true);
  }

  void _onKeyboardTap(String value)async {
    setState(() {
      text = text + value;
    });
    if(text.length == 4){



      var code = await codeDB();
      if(code == 0){
        print("err code");
        animation();
      }else
      if(code == int.parse(text)){
        print("ok");

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
                      Text("Код для входа", style: TextStyle(color: cMainText, fontSize: 24, fontFamily: "MPLUS",),),
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
              textColor: cMainText,
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

