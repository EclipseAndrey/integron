import 'package:flutter/material.dart';
import 'package:omega_qick/AutoRoutes.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogLoading.dart';
import 'package:omega_qick/presentation/integron_icons.dart' as customIcons;
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Style.dart';


class AboutReferal extends StatefulWidget {
  @override
  _AboutReferalState createState() => _AboutReferalState();
}

class _AboutReferalState extends State<AboutReferal> {

  bool logo = true;
  double divBefore = 40; //40 20
  double divAfter = 20; //20 5
  double sizedAfterTool = 50; //50 0
  double minusIconSize = 0; // 0 10
  double minusFontsSize = 0; // 0 4
  double marginnTop = 30;


  double beforeLogo= 50;
  double afterText= 50;
  double betweenText= 10;





  @override
  Widget build(BuildContext context) {

    double shortestSide = MediaQuery.of(context).size.shortestSide;
    print(shortestSide);

    if(shortestSide < 400){
      logo = false;
      divBefore = 20; //40 20
      divAfter = 5; //20 5
      sizedAfterTool = 50; //50 0
      minusIconSize = 10; // 0 10
      minusFontsSize = 4; // 0 4
      marginnTop = 0;

      beforeLogo= 50;
      afterText= 50;
      betweenText= 10;


    }
    if(shortestSide >= 400 && shortestSide <= 420){
      divBefore = 40; //40 20
      divAfter = 5; //20 5
      sizedAfterTool = 0; //50 0
      minusIconSize = 0; // 0 10
      minusFontsSize = 0; // 0 4
      marginnTop = 60;


      beforeLogo= 50;
      afterText= 50;
      betweenText= 10;

    }



    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: cBG,
        child: Content(),
      ),
    );
  }

  Widget Content(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            SizedBox(height: 50,),
            Text("Зарабатывайте вместе с нами",textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 27, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal, fontFamily: fontFamily),),
            SizedBox(height: 6,),
            Text("Скоро мы запустим реферальную программу",textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1), fontSize: 16, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal, fontFamily: fontFamily),),
            SizedBox(height: 12,),
           // Logo(context, divBefore, minusFontsSize, minusIconSize),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                  child: Image.asset("lib/assets/images/referal.png")),
            ),
          ],
        ),

        TextWelcome(),
        SizedBox(height: 50,),

      ],
    );


  }

  Widget Logo(BuildContext context, double divBefore, double minusFontsSize, double minusIconSize){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            child: Icon(customIcons.Integron.integron, color: cMainText, size: 20 - minusIconSize,)),
        SizedBox(height: 20,),

        SizedBox(height: divBefore,),
        Container(
            width: 128,
            child: Divider()),

      ],
    );
  }

  Widget TextWelcome(){
    return Column(
      children: [
        Text("", style: TextStyle(color: cMainText, fontWeight: FontWeight.w400, fontSize: 27 - minusFontsSize, fontStyle: FontStyle.normal),),
        SizedBox(height: 10,),
        Text("Вы сможете  развивать сервис вместе с нами, привлекая новые бизнесы на платформу. За каждый бизнес вы будете получать вознаграждение.", textAlign: TextAlign.center, style: TextStyle(color: cMainText, height: 2, fontWeight: FontWeight.w400, fontSize: 14 - minusFontsSize, fontStyle: FontStyle.normal),),
      ],
    );
  }


}
