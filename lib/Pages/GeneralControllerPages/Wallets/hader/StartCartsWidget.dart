import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:integron/AAPages/Blocs/Balance/BalanceCubit.dart';
import 'package:integron/AAPages/Blocs/History/HistoryCubit.dart';
import 'package:integron/Pages/GeneralControllerPages/Home/Settings.dart';
import 'package:integron/Providers/WalletProvider/WalletProvider.dart';
import 'package:integron/Style.dart';
import 'package:integron/Utils/DB/Wallet/Balance.dart';
import 'package:integron/Utils/IconDataForCategory.dart';
import 'package:integron/Utils/fun/DialogsIntegron/DialogIntegron.dart';

import 'package:integron/Utils/fun/QrLib/QrGenerate/QrGenerateController.dart';
import 'package:integron/main.dart';

import 'logo.dart';



class StartCarts extends StatefulWidget {
  @override
  _StartCartsState createState() => _StartCartsState();
}

class _StartCartsState extends State<StartCarts> with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Animation<double> animation;

  bool loadingBalance = true;




  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() => setState(() {}));
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutBack,
    );
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Content();
  }

  Widget Content() {
    var size = MediaQuery.of(context).size;

    double cardSize = 0.90;
    return Container(
      height: size.width*0.80*0.70*cardSize+100,
      color: cBG,
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
    print(size.width);
    double xx = 0;
    if(size.width < 360){ xx = 30;}

    return BlocBuilder<BalanceCubit,BalanceState>(
      builder: (context, state) => ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        child: Container(
          color: c2f527f,
          width: size.width*cardSize,
          height: size.width*0.75*0.70*cardSize+xx,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("DEL ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontFamily: fontFamily, fontSize: 24, fontStyle: FontStyle.normal),),
                    getIconSvg(id: 15, color: Colors.white, size: 24),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        animationController.forward(from: 0);
                        BlocProvider.of<BalanceCubit>(context).load();
                        BlocProvider.of<HistoryCubit>(context).load();
                      },
                      child: RotationTransition(
                          turns: animation,
                          child: getIconSvg(id: 37, color: Colors.white, size: 24)),
                    ),
                    SizedBox(width: 8,),
                    (state is BalanceComplete)?Text( state.balance.balance.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontFamily: fontFamily, fontSize: 24, fontStyle: FontStyle.normal),):CircularProgressIndicator(),
                  ],
                ),
                Row(
                  children: [
                    Text("Кошелек", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontFamily: fontFamily, fontSize: 16, fontStyle: FontStyle.normal),),
                    Spacer(),
                    Text((state is BalanceComplete)?"${(state.balance.balance*course).toStringAsFixed(3)} ":"", style: TextStyle(color: cb4bfb3, fontWeight: FontWeight.w400, fontFamily: fontFamily, fontSize: 16, fontStyle: FontStyle.normal),),
                    Text((state is BalanceComplete)?" ₽":"", style: TextStyle(color: cb4bfb3, fontWeight: FontWeight.w400,  fontSize: 16, fontStyle: FontStyle.normal),),
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
                      GestureDetector(
                        onTap: ()async{
                          Balance info = await WalletProvider.getBalance();
                          showDialogIntegron(context: context, title: getQr(info.address, size: MediaQuery.of(context).size.width*0.3), body: GestureDetector(
                              onTap: (){

                                  Fluttertoast.showToast(
                                      msg: "Адрес скопирован",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      fontSize: 16.0
                                  );
                                  Clipboard.setData( ClipboardData(text: info.address));

                              },
                              child: Text(info.address+ "\nНажмите чтобы скопировать", textAlign: TextAlign.center, style: TextStyle(color: cLinks),)));
                        },
                        child: Container(

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
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: ()async{
                            Balance info = await WalletProvider.getBalance();

                            showDialogIntegron(context: context, title: getQr(info.address, size: MediaQuery.of(context).size.width*0.3), body: GestureDetector(
                                onTap: (){

                                  Fluttertoast.showToast(
                                      msg: "Адрес скопирован",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      fontSize: 16.0
                                  );
                                  Clipboard.setData( ClipboardData(text: info.address));

                                },
                                child: Text(info.address + "\nНажмите чтобы скопировать", textAlign: TextAlign.center, style: TextStyle(color: cLinks), )));
                          },
                          child: getIconSvg(id:35, size: 38, color: Colors.white,))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



