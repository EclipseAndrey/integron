import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/presentation/integron_icons.dart' as cutomIcons;

import 'Style.dart';

Widget HaveAccount(BuildContext context, double minusFontsSize) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "Уже eсть аккаунт? ",
        style: TextStyle(color: cMainBlack,
          fontSize: 16 - minusFontsSize,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,

        ),

      ),
      GestureDetector(
        onTap: (){
          //TODO: press Login
        },
        child: Text(
          " Войти",
          style: TextStyle(color: c8dcde0,
            fontSize: 16 - minusFontsSize,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,

          ),

        ),
      ),
    ],
  );
}
