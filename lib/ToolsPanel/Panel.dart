import 'package:flutter/material.dart';
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/fun/InitBalance.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/QrLib/QrScanner/QrScannerController.dart';
import 'package:omega_qick/ToolsPanel/PayDialog.dart';
import 'package:omega_qick/ToolsPanel/SendBeforeMyWallets/SendBeforeMyWallets.dart';

import '../JsonParse.dart';
import 'BuildBillDialog.dart';
import 'DepositDialog.dart';

class ToolsPanel extends StatefulWidget {
  User user;
  List<User> wallets;
  List<AddressA> adresses;

  String seed;

  ToolsPanel(this.user, this.seed, this.wallets, this.adresses);


  @override
  _ToolsPanelState createState() => _ToolsPanelState();
}

class _ToolsPanelState extends State<ToolsPanel> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(25.0)
            ),
        border: Border.all(
          color: Colors.white,
          width: 1, //

        ),
      ),
      width: size.width * 0.95,
      height: size.width * 0.80 * 0.30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlatButton(
            textColor: Colors.white54,
            shape: CircleBorder(

            ),
            onPressed: (){
              showDepositDialog(context, widget.user.result.address.address);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(
                  Icons.add_circle,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Получить",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "MPLUS",
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            textColor: Colors.white54,
            shape: CircleBorder(

            ),
            onPressed: ()async{
              pyaDialog(context, widget.seed, InitBalace(widget.user.result.address.balance.del));

            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_money,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Перевести",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "MPLUS",
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            textColor: Colors.white54,
            shape: CircleBorder(

            ),
            onPressed: (){
             // BuildBillDialog(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SendBeforeMyWallets(widget.wallets,widget.adresses)));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.compare_arrows,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Между своими",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "MPLUS",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
