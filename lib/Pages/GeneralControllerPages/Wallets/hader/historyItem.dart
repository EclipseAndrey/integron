import 'package:flutter/material.dart';
import 'package:integron/Pages/GeneralControllerPages/Wallets/ContainerHistory/data.dart';
import 'package:integron/Pages/GeneralControllerPages/Wallets/ContainerHistory/name.dart';
import 'package:integron/Pages/GeneralControllerPages/Wallets/ContainerHistory/status.dart';
import 'package:integron/Pages/GeneralControllerPages/Wallets/ContainerHistory/summ.dart';
import 'package:integron/Pages/GeneralControllerPages/Wallets/ContainerHistory/usd.dart';
import 'package:integron/Pages/GeneralControllerPages/Wallets/ContainerHistory/uslug.dart';
import 'package:integron/Utils/DB/Wallet/Tx.dart';
import 'dart:math' as math;
import 'package:integron/Utils/fun/InitBalance.dart';
import 'package:integron/Utils/fun/InitWallet.dart';
import 'package:integron/Utils/fun/TimeParse.dart';

Widget historiItem(BuildContext context, {Tx tx}) {
  Color c7A8BA3 = Color.fromRGBO(122, 139, 163, 1);
  Color c6287A1 = Color.fromRGBO(98, 135, 161, 1);
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 3,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    width: MediaQuery.of(context).size.width,
    // height: MediaQuery.of(context).size.height * 0.07,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              dataWidget(txTimeParseDate(tx.date)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: nameWidget(tx.face)),
                type(tx.type),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    summWidget(InitBalace(tx.amount)),
                    usdWidget(tx.currency),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0, top:  4),
                  child: statusWidget(tx.status, context),
                ),
              ],
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Transform.rotate(
                      angle: 90 * math.pi / 180,
                      child: Icon(Icons.linear_scale , color: c6287A1 , )),
                ),
              ])
        ],
      ),
    ),
  );
}
