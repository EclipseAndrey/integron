import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omega_qick/HomePage/AddWallet/AddWalletBottomModalSheet.dart';
import 'package:omega_qick/Style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Utils/fun/CopyText.dart';
import '../Utils/fun/InitBalance.dart';
import '../Utils/fun/InitWallet.dart';
import '../JsonParse.dart';
import 'Colors.dart';
import 'Const.dart';
import 'Strings.dart';

Widget CardWallet(User user, BuildContext context) {

  String convert(String summ){
    double res = double.parse(summ)*14.5;
    if(res!=0)return "~"+res.toStringAsFixed(3).toString()+" ₽";
    else return "";
  }


  var size = MediaQuery.of(context).size;
  return ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: cardBackgroundGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      width: size.width * 0.80,
      height: size.width * 0.80,
      child: user.errors? Center(child: Text("Ошибка загрузки", style: TextStyle(color: Colors.white, fontSize: 18),)):Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        StringsHeader.nameBalance,
                        style: TextStyle(
                          color: ColorsHeader.h1,
                          fontSize: SizedFonts.BalanceSizeH1,
                          fontFamily: "MPLUS",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        InitBalace(user.result.address.balance.del) + " DEL ",
                        style: TextStyle(
                          color: ColorsHeader.h2,
                          fontSize: SizedFonts.BalanceSizeH2,
                          fontWeight: FontWeight.bold,
                          fontFamily: "MPLUS",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        convert(InitBalace(user.result.address.balance.del)),
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "MPLUS",
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(bottom: 8.0),
                    //   child: Text("Обновлено $time сек.",
                    //     style: TextStyle(
                    //       color: ColorsHeader.h1,
                    //       fontSize: SizedFonts.BalanceSizeH1-4,
                    //       fontFamily: "MPLUS",
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      " DEL",
                      style: TextStyle(
                        color: ColorsHeader.h2,
                        fontSize: SizedFonts.BalanceSizeH2 - 2,
                        fontWeight: FontWeight.w600,
                        fontFamily: "MPLUS",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          color: Colors.green.withOpacity(1),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "+3.2%",
                              style: TextStyle(
                                color: ColorsHeader.h2,
                                fontSize: SizedFonts.BalanceSizeH2 - 8,
                                fontWeight: FontWeight.w600,
                                fontFamily: "MPLUS",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        StringsHeader.nameWallet,
                        style: TextStyle(
                          color: ColorsHeader.h1,
                          fontSize: SizedFonts.walletSizeH1,
                          fontFamily: "MPLUS",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CopyText(
                            message: "Копировать",
                            copyText: user.result.address.address,
                            child: Text(
                              InitWallet(user.result.address.address),
                              style: TextStyle(
                                color: ColorsHeader.h2,
                                fontSize: SizedFonts.walletSizeH2,
                                fontFamily: "MPLUS",
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              print("Copy button");
                              Fluttertoast.showToast(
                                  msg: "Адрес скопирован",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black45,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Clipboard.setData( ClipboardData(text: user.result.address.address));
                            },

                            shape: CircleBorder() ,
                            color: Colors.transparent,
                            textColor: Colors.pinkAccent,
                            child: Icon(
                              Icons.content_copy,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: GestureDetector(
                    onTap: (){
                      AddWalletDialog(context);
                    },
                    child: Container(
                        color: Colors.white24,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        )),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
