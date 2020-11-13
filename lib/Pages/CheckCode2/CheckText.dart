import 'package:flutter/cupertino.dart';

import 'package:omega_qick/Pages/Login2/Style.dart';

Widget CheckText (BuildContext context, minusFontsSize){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("Подтвердите код", style:  TextStyle(color:  cMainText, fontSize:  27 - minusFontsSize, fontWeight: FontWeight.w400, fontStyle:  FontStyle.normal),),
      SizedBox(height: 20,),
      Text("Код выслан в СМС", style: TextStyle(color:  cMainText, fontSize: 16 - minusFontsSize, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600))
    ],
  );
}