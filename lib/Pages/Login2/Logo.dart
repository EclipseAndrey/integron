import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omega_qick/presentation/integron_icons.dart' as customIcons;

import 'Style.dart';

Widget Logo(BuildContext context, double divBefore, double minusFontsSize, double minusIconSize){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
          width: MediaQuery.of(context).size.width,
          child: Icon(customIcons.Integron.integron, color: cMainText, size: 20 - minusIconSize,)),
      SizedBox(height: 20,),
      Text("магазин товаров и услуг за токены", style: TextStyle(
        color: c7A8BA3,
        fontSize: 16 - minusFontsSize,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),),
      SizedBox(height: divBefore,),
      // Container(
      //     width: 128,
      //     child: Divider()),

    ],
  );
}