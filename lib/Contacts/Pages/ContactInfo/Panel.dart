import 'package:flutter/material.dart';
import 'package:omega_qick/Authorization/WalletDB.dart';
import 'package:omega_qick/Contacts/DataBase/AddContacts.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/Contacts/DataBase/DBDeleteContacts.dart';
import 'package:omega_qick/Contacts/SendToContact/SendToContact.dart';
import 'package:omega_qick/DialogLoading/DialogLoading.dart';
import 'package:omega_qick/JsonParse.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/REST/GetUser.dart';
import 'package:omega_qick/REST/getWalletR.dart';
import 'package:omega_qick/ToolsPanel/DepositDialog.dart';

class Panel extends StatefulWidget {
  Contact contact;
  Panel(this.contact);
  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  @override
  Widget build(BuildContext context) {
    return panel();
  }



  Widget panel() {
    double t = 14;
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              showDialogLoading(context);
              List<User> users = [];
              List<AddressA> addresses = [];
              List<WalletData> walletData = await DBProvider.db.WalletDB();
              List<AddressA> addressesStep = [];

              for (int i = 0; i < walletData.length; i++) {
                addressesStep.add(AddressA(
                    address: walletData[i].address,
                    mnemonic: walletData[i].seed));
              }

              users = await GetUsers(addressesStep, context);
              addresses = addressesStep;
              User user = await getUser(widget.contact.address, context);
              closeDialog(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SendToContact(users,addresses, widget.contact, user.result.address.balance.del )));


            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(34, 15, 45, .3),
                        blurRadius: 10,
                        offset: Offset(-2.5, 5))
                  ]),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.send,
                      color: Colors.white.withOpacity(0.9),
                      size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text("Перевод",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "MPLUS",
                              fontSize: t)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDepositDialog(context, widget.contact.address);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(34, 15, 45, .3),
                        blurRadius: 10,
                        offset: Offset(-2.5, 5))
                  ]),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings_overscan,
                      color: Colors.white.withOpacity(0.9),
                      size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text("Qr",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "MPLUS",
                              fontSize: t)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              //TODO
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(34, 15, 45, .3),
                        blurRadius: 10,
                        offset: Offset(-2.5, 5))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.white.withOpacity(0.9),
                    size: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text("Запросить",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "MPLUS",
                            fontSize: t)),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()async {

              if(widget.contact.priory == 0){
                widget.contact.priory =1;
                setState(() {

                });
                await deleteContacts(address: widget.contact.address);
                await AddContact(widget.contact);

              }else{
                widget.contact.priory =0;
                setState(() {

                });
                await deleteContacts(address: widget.contact.address);
                await AddContact(widget.contact);
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(34, 15, 45, .3),
                        blurRadius: 10,
                        offset: Offset(-2.5, 5))
                  ]),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //jh
                    Icon(
                      widget.contact.priory == 1?Icons.star:Icons.star_border,
                      color: Colors.white.withOpacity(0.9),
                      size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text("Избранное",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "MPLUS",
                              fontSize: t)),
                    ),
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
