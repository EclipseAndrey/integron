import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';

import 'logo.dart';

Widget StartsCarts(BuildContext context) {
  var size = MediaQuery.of(context).size;

  double cardSize = 0.90;
  return Container(
    height: size.width*0.80*0.70*cardSize+100,
    color: cBackground,
    width: MediaQuery.of(context).size.width,
    child: Stack(
      children: [
        Container(
            height: size.width*0.80*0.70*cardSize+100,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("lib/assets/images/complex.png", fit: BoxFit.fill,)),
        Align(
            alignment: Alignment.bottomCenter
            ,child: Container(
              height: size.width*0.80*0.70*cardSize+100,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  logo(),
                  WalletIntegron(context, cardSize),
                ],
              ),
            )),
      ],
    ),
  );
}

Widget WalletIntegron(BuildContext context, double cardSize){
  var size = MediaQuery.of(context).size;

  return ClipRRect(
    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    child: Container(
      color: c2f527f,
      width: size.width*cardSize,
      height: size.width*0.75*0.70*cardSize,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("DEL ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontFamily: fontFamily, fontSize: 24, fontStyle: FontStyle.normal),),
                getIconForId(id: 15, color: Colors.white, size: 24),
                Spacer(),
                getIconForId(id: 37, color: Colors.white, size: 24),
                SizedBox(width: 4,),
                Text("123,123", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontFamily: fontFamily, fontSize: 24, fontStyle: FontStyle.normal),)
              ],
            ),
            Row(
              children: [
                Text("Кошелек", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontFamily: fontFamily, fontSize: 16, fontStyle: FontStyle.normal),),
                Spacer(),
                Text("123,123 ", style: TextStyle(color: cb4bfb3, fontWeight: FontWeight.w400, fontFamily: fontFamily, fontSize: 16, fontStyle: FontStyle.normal),),
                Text("₽", style: TextStyle(color: cb4bfb3, fontWeight: FontWeight.w400,  fontSize: 16, fontStyle: FontStyle.normal),),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Text("Последняя транзакция ", style: TextStyle(color: cDefault, fontWeight: FontWeight.w400, fontFamily: fontFamily, fontSize: 12, fontStyle: FontStyle.normal),),
                Text("3 дня назад", style: TextStyle(color: cDefault, fontWeight: FontWeight.w700, fontFamily: fontFamily, fontSize: 16, fontStyle: FontStyle.normal),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Container(

                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.white
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                      child: Center(
                        child:
                        Text("Пополнить", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: fontFamily, fontSize: 14, fontStyle: FontStyle.normal),),
                      ),
                    ),
                  ),
                  Spacer(),
                  getIconForId(id:35, size: 38, color: Colors.white,)
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}