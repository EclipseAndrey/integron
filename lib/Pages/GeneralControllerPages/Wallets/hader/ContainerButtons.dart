import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Wallets/buttonDown.dart';
import 'package:omega_qick/Pages/GeneralControllerPages/Wallets/hader/buttons.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';
import 'package:omega_qick/Utils/IconDataForCategory.dart';

Widget containerButtons(BuildContext context) {
  Color cBackground = Color.fromRGBO(250, 250, 250, 1);
  return Container(
    color: cBackground,
    width: MediaQuery.of(context).size.width,
    // height: MediaQuery.of(context).size.height * 0.39,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              byTokensButton(context),
              ButtonsRight(context),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget byTokensButton(BuildContext context) {
  double w = MediaQuery.of(context).size.width * 0.43;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 5.0,
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 3,
        )
      ],
    ),
    width: w,
    height: w * 10 / 9,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5),
          getIconForId(id:3,
            color: c6287A1,
            size: 32,
          ),
          SizedBox(height: 7),
          Text("Купить токены",
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(88, 148, 188, 1),
                fontWeight: FontWeight.w400,
              )),
        ],
      ),
    ),
  );
}

Widget ButtonsRight(BuildContext context) {
  double w = MediaQuery.of(context).size.width * 0.43;
  double h = w * 10 / 27 - 4;
  Color textColor = Color.fromRGBO(88, 148, 188, 1);

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
            )
          ],
        ),
        width: w,
        height: h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 16,),

            getIconForId(id:28, color: c6287A1),
            SizedBox(width: 16,),
            Text("Продать", style: TextStyle(fontSize: 16, color: textColor)),
          ],
        ),
      ),

      SizedBox(height:  6,),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
            )
          ],
        ),
        width: w,
        height: h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 16,),

            getIconForId(id:1, color: c6287A1),
            SizedBox(width: 16,),

            Text("Перевести", style: TextStyle(fontSize: 16, color: textColor)),
          ],
        ),
      ),
      SizedBox(height: 6,),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
            )
          ],
        ),
        width: w,
        height: h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 16,),

            getIconForId(id:2, color: c6287A1),
            SizedBox(width: 16,),

            Text("Поменяться", style: TextStyle(fontSize: 16, color: textColor)),
          ],
        ),
      ),
    ],
  );
}
