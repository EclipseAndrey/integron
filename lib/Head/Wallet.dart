import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:omega_qick/Head/Const.dart';
import 'package:omega_qick/Head/Strings.dart';

import '../JsonParse.dart';
import 'Colors.dart';

Widget WalletWidget(User user, BuildContext context){
  return  Container(
    width: MediaQuery.of(context).size.width * 0.90,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            ColorsHeader.gradient1,
            ColorsHeader.gradient2,
            ColorsHeader.gradient3,
            ColorsHeader.gradient4,

          ],
        ),
        ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding:  EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.only(bottom: 8.0),
              child: Text(
                StringsHeader.nameWallet,
                style: TextStyle(
                  color: ColorsHeader.h1,
                  fontSize: SizedFonts.walletSizeH1,
                  fontFamily: "MPLUS",
                ),
              ),
            ),
//                      Text(
//                        " ${_user.result.address.address}",
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: 16,
//                          fontFamily: "MPLUS",
//                        ),
//                      ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                user.result.address.address,
                style: TextStyle(
                  color: ColorsHeader.h2,
                  fontSize: SizedFonts.walletSizeH2,
                  fontFamily: "MPLUS",
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );

}