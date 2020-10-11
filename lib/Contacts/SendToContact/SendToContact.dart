

import 'package:flutter/material.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/InitBalance.dart';
import 'package:omega_qick/InitWallet.dart';
import 'package:omega_qick/JsonParse.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/Style.dart';

import 'ButtonSend.dart';
import 'FieldSumm.dart';
import 'SelectWalletBottomSheet.dart';

class SendToContact extends StatefulWidget {
  List<User> wallets;
  List<AddressA> adresses;
  Contact to;
  String del;

  SendToContact(this.wallets, this.adresses,this.to, this.del);

  @override
  _SendToContactState createState() => _SendToContactState();
}

class _SendToContactState extends State<SendToContact> {
  User walletS = null;
  User walletZ = null;
  TextEditingController controllerSumm = TextEditingController();

  @override
  Widget build(BuildContext context) {

    controllerSumm.addListener(() {
      if(controllerSumm.text.length > 0){
        // RegExp exp = RegExp(r"\-?\d+(\.\d{0,})?");
        // controllerSumm.text = controllerSumm.text.replaceAll(exp, '');
        // controllerSumm.selection = TextSelection.fromPosition(TextPosition(offset: controllerSumm.text.length));



      }
    });

    return Theme(
      data: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor:homeBackgroundGradient[0],
        accentColor: homeBackgroundGradient[0],

        // Define the default font family.
        fontFamily: 'MPLUS',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 16.0, fontFamily: 'Medium'),
        ),

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.

      ),
      child: Scaffold(
        backgroundColor: homeBackgroundGradient[0],
        appBar: AppBar(
          title: Text("Перевод"),
        ),
        body: Content(),
      ),
    );
  }

  Widget Content() {


    Color colorDiv = Colors.white60;

    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(
            color: colorDiv,
          ),
          ItemWallet(true),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(height: 50,),
          ),
          to (),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: inputSumm(controllerSumm),
          ),
          buttonSendDel(widget.adresses, walletS,
              widget.to.address, context, controllerSumm),
        ],
      ),
    );
  }
  Widget to (){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom:  8),
            child: Text( "Счет зачисления", style: TextStyle(fontSize: 16),),
          ),
          Container(
            height: 80,
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Счет Decimal"),
                        Text(InitWallet(widget.to.address) + "  " + widget.to.name),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "${InitBalace(widget.del)} DEL"),
                            ),

                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ItemWallet(bool spisanie) {
    onWalletChange(wallet) {
      if (spisanie){
        walletS = wallet;
        if(walletS == walletZ)walletZ = null;
      }
      else{
        walletZ = wallet;
        if(walletS == walletZ)walletS = null;
      }

      setState(() {});
    }

    User wal = spisanie ? walletS : walletZ;

    if (wal != null) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom:  8),
              child: Text(spisanie ? "Счет списания" : "Счет зачисления", style: TextStyle(fontSize: 16),),
            ),
            GestureDetector(
              onTap: () async {
                try {
                  selectWallet(context, widget.wallets, onWalletChange, spisanie);
                  setState(() {});
                } catch (e) {}
              },
              child: Container(
                height: 80,
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Счет Decimal"),
                            Text(InitWallet(spisanie
                                ? walletS.result.address.address
                                : walletZ.result.address.address)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "${InitBalace(spisanie ? walletS.result.address.balance.del : walletZ.result.address.balance.del)} DEL"),
                                ),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom:  8),
              child: Text(spisanie ? "Счет списания" : "Счет зачисления"),
            ),
            GestureDetector(
              onTap: () async {
                try {
                  selectWallet(context, widget.wallets, onWalletChange, spisanie);
                  setState(() {});
                } catch (e) {}
                setState(() {});
              },
              child: Container(
                height: 80,
                color: Colors.white12,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Счет Decimal"),
                            Text("Нажмите, чтобы выбрать"),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(""),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
