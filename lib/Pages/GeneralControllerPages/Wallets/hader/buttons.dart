import 'package:flutter/material.dart';
import 'package:omega_qick/Pages/Login2/Style.dart';

import 'ButtonRightConstr.dart';


Widget StartWidget(String title, IconData icon, BuildContext context) {
  double w = MediaQuery.of(context).size.width * 0.43;
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05, top: 12),
            child: Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5),
                  Center(
                      child: Icon(
                    icon,
                    color: c6287A1,
                    size: 40,
                  )),
                  SizedBox(height: 7),
                  Text(title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(88, 148, 188, 1),
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
      Spacer(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Buttons("Продать", Icons.face, context),
          Buttons("Перевести", Icons.arrow_forward, context),
          Buttons("Поменяться", Icons.compare_arrows, context),
        ],
      )
    ],
  );
}
