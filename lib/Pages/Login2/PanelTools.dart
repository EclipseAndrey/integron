import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:integron/presentation/integron_icons.dart' as customIcons;
import 'package:integron/Style.dart';


Widget PanelTools(BuildContext context, double minusIconSize){

  Widget tools(){

    double sizeBox = 0.15;
    double paddingtext = 10;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width*sizeBox,
              width: MediaQuery.of(context).size.width*sizeBox,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: cb4bfb3,
                    width: 1.0
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(6.0) //
                ),
              ),
              child: Center(
                child: Icon(customIcons.Integron.email, size: 32- minusIconSize, color: c5894bc,),
              ),
            ),
            SizedBox(height: paddingtext,),
            Text("E-mail", style: TextStyle(color: cMainText, fontSize: 12, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),)
          ],
        ),
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width*sizeBox,
              width: MediaQuery.of(context).size.width*sizeBox,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: cb4bfb3,
                    width: 1.0
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(6.0) //
                ),
              ),
              child: Center(
                child: Icon(customIcons.Integron.google, size: 32 -minusIconSize, color: c5894bc,),
              ),
            ),
            SizedBox(height: paddingtext,),
            Text("Google", style: TextStyle(color: cMainText, fontSize: 12, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),)
          ],
        ),
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width*sizeBox,
              width: MediaQuery.of(context).size.width*sizeBox,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: cb4bfb3,
                    width: 1.0
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(6.0) //
                ),
              ),
              child: Center(
                child: Icon(customIcons.Integron.facebook_f, size: 32 -minusIconSize, color: c5894bc,),
              ),
            ),
            SizedBox(height: paddingtext,),
            Text("Facebook", style: TextStyle(color: cMainText, fontSize: 12, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),)
          ],
        ),
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width*sizeBox,
              width: MediaQuery.of(context).size.width*sizeBox,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: cb4bfb3,
                    width: 1.0
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(6.0) //
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(customIcons.Integron.vk, size: 28 -minusIconSize, color: c5894bc,),
                ),
              ),
            ),
            SizedBox(height: paddingtext,),
            Text("Vkontakte", style: TextStyle(color: cMainText, fontSize: 12, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),)
          ],
        ),
      ],
    );
  }


  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text("Создать аккаунт с помощью", style: TextStyle(color: cMainText, fontSize: 16, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),),
      SizedBox(height: 10,),
      tools()
    ],
  );
}