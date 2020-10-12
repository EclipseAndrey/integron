import 'dart:async';

import 'package:flutter/material.dart';
import 'package:omega_qick/Authorization/WalletDB.dart';
import 'package:omega_qick/Contacts/DataBase/GetContactForAddress.dart';
import 'package:omega_qick/Head/ControllerHeader.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/Parse/txs.dart';
import 'package:omega_qick/REST/GetUser.dart';
import 'package:omega_qick/REST/getAddress.dart';
import 'package:omega_qick/ToolsPanel/Panel.dart';

import '../JsonParse.dart';
import '../Style.dart';
import 'HistoryTxs/HistoryTxsController.dart';

class Home extends StatefulWidget {
  bool loading = true;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _HomeState();

  Timer timer;
  Timer timer2;
  List<User> users = [];
  List<AddressA> addresses = [];
  PageController controllerWallets = PageController();

  void UpdateData() async {
    List<WalletData> walletData = await DBProvider.db.WalletDB();
    List<AddressA> addressesStep = [];

    for (int i = 0; i < walletData.length; i++) {
      addressesStep.add(AddressA(
          address: walletData[i].address, mnemonic: walletData[i].seed));
    }

    users = await GetUsers(addressesStep, context);
    addresses = addressesStep;
    for(int j =0 ; j <  users.length; j++){
      for(int i = 0; i < users[j].result.address.txs.length; i++){
        bool send = users[j].result.address.address == users[j].result.address.txs[i].data.sender?true:false;

        var resContact = await getContactForAddress(!send?users[j].result.address.txs[i].data.sender:users[j].result.address.txs[i].to);
        print("check base contacts == ${resContact.errors}");
        if(!resContact.errors)users[j].result.address.txs[i].name = resContact.name;
      }
    }
    setState(() {
      widget.loading = false;
    });
  }
  void setState1(){
    setState(() {

    });
  }


  @override
  void initState() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => UpdateData());
    timer2?.cancel();
    timer2 = Timer.periodic(Duration(seconds: 1), (Timer t) => setState1());


  }


  @override
  void dispose() {
    timer?.cancel();
    timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    int page ;

    try{
    page = controllerWallets.page.round();
    }catch(e){

    }
    controllerWallets.addListener(() {
      if(page != controllerWallets.page.round()){
        page = controllerWallets.page.round();
        setState(() {

        });
      }
    });
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: 14.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: homeBackgroundGradient,
                begin: Alignment.centerLeft,
                end: Alignment.bottomCenter)),
        width: size.width,
        height: size.height,
        child: widget.loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.purple,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //     height: size.height*0.20,child: HeadSwiper(context, _user)),
                      Header(users, controllerWallets),
                      SizedBox(
                        height: 18,
                      ),
                      controllerWallets.positions.isEmpty? SizedBox():ToolsPanel(users[page == null ? 0 : page], addresses[page == null ? 0 : page].mnemonic, users,addresses),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: Colors.white60,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "История транзакций",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "MPLUS",
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      controllerWallets.positions.length == 0
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.purple,
                                ),
                              ),
                            )
                          :
                      historyTxs(page),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget historyTxs(int page) {


    try {
      return Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            users[page == null ? 0 : page].result.address.txs.length == 0 ? Text(
                    "У вас пока не было транзакций",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontFamily: "MPLUS",
                        fontWeight: FontWeight.w400),)
                : SizedBox(),

            users[page == null ? 0 : page].result.address.txs.length != 0 ?
            HistoryTxs(users[page == null ? 0 : page].result.address.txs, context, users[page == null ?
            0 : page]) : SizedBox(),
          ],
        ),
      );
    } catch (e) {
      print("----");
      print(controllerWallets.page.toStringAsFixed(0));
      print(e);
      return Center();
    }
  }
}
