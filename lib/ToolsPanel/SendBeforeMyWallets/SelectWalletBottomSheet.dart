import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/fun/InitBalance.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/fun/InitWallet.dart';
import 'package:omega_qick/JsonParse.dart';
import 'package:omega_qick/Login1/Style.dart';
import 'package:omega_qick/Style.dart';




Future<User> selectWallet(BuildContext context, List<User> wallets, ValueChanged<User> wallet, bool s) async{


  showBarModalBottomSheet(
    backgroundColor: homeBackgroundGradient[0],
    context: context,
    builder: (context, scrollController) {
      return Container(
        color: homeBackgroundGradient[0],

        height: 400,
        child: Material(
          color: homeBackgroundGradient[0],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(s?"Счет списания":"Счет зачисления",style: TextStyle(color: Colors.white, fontSize: 18),),
                  ),
                  Column(
                    children: List.generate(wallets.length, (index) {
                      bool select = true;
                      return GestureDetector(
                        onLongPressStart: (i){select = true;},
                        onLongPressEnd: (i){select = false;},
                        onTapDown: (i){select = true;},
                        onTapUp: (i){select = false;},
                        onTap: (){
                          Navigator.pop(context);
                          print("wallet "+ InitWallet(wallets[index].result.address.address));
                          wallet(wallets[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white10,
                                boxShadow: [BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(-2.5, 7)
                                )]
                            ),
                            duration: Duration(milliseconds: 70),

                            height: 90,
                            child: wallets[index].errors?Center(child: Text("Не удалось загрузить, попробуйте позже", style: TextStyle(color: Colors.white)),):Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 18.0, right: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Счет Decimal", style: TextStyle(color: Colors.white),),
                                        Text(InitWallet(wallets[index].result.address.address), style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${InitBalace(wallets[index].result.address.balance.del)} DEL", style: TextStyle(color: Colors.white)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
