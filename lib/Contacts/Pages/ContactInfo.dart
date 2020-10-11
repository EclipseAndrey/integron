import 'package:flutter/material.dart';
import 'package:omega_qick/Authorization/WalletDB.dart';
import 'package:omega_qick/Contacts/DataBase/AddContacts.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/Contacts/DataBase/DBDeleteContacts.dart';
import 'package:omega_qick/Contacts/SendToContact/SendToContact.dart';
import 'package:omega_qick/DialogLoading/DialogLoading.dart';
import 'package:omega_qick/JsonParse.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/Parse/tx.dart';
import 'package:omega_qick/REST/GetUser.dart';
import 'package:omega_qick/REST/getWalletR.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/TimeParse.dart';
import 'package:omega_qick/ToolsPanel/DepositDialog.dart';
import 'package:share/share.dart';

import '../../InitBalance.dart';
import '../../InitWallet.dart';
import 'AddContact.dart';
import 'AddContactContent/AddContactController.dart';

class ContactInfo extends StatefulWidget {
  Contact contact;

  ContactInfo(this.contact);

  @override
  _ContactInfoState createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: homeBackgroundGradient[0],
        accentColor: homeBackgroundGradient[0],

        // Define the default font family.
        fontFamily: 'MPLUS',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(
              fontSize: 18.0, fontFamily: 'Medium', color: Colors.white),
        ),

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
      ),
      child: Scaffold(
        backgroundColor: homeBackgroundGradient[0],
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () async {
                Share.share(
                    "Контакт\n${widget.contact.name}\n\nАдрес: ${widget.contact.address}",
                    );

                // await AddContactBottomSheet(context, contact: widget.contact);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddContactContent.edit(widget.contact)));
                // await AddContactBottomSheet(context, contact: widget.contact);
              },
            )
          ],
          elevation: 0,
        ),
        body: Content(),
      ),
    );
  }

  Widget panel() {
    double t = 14;
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
            child: GestureDetector(
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
          Container(
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
            child: GestureDetector(
              onTap: () {
                showDepositDialog(context, widget.contact.address);
              },
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
          Container(
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
          Container(
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
            child: GestureDetector(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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

  Widget address() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.90,
          decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(34, 15, 45, .3),
                    blurRadius: 10,
                    offset: Offset(-2.5, 5))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text("Адрес",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "MPLUS",
                          fontSize: 16)),
                ),
                SizedBox(
                  height: 3,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(widget.contact.address,
                      style: TextStyle(
                          color: Colors.white60,
                          fontFamily: "MPLUS",
                          fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget note() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.width * 0.30,
          decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(34, 15, 45, .3),
                    blurRadius: 10,
                    offset: Offset(-2.5, 5))
              ]),
        ),
      ],
    );
  }

  Widget events() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.90,
          decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(34, 15, 45, .3),
                    blurRadius: 10,
                    offset: Offset(-2.5, 5))
              ]),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                    child: Text(
                      "Поделиться",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Divider(
                    color: Colors.white60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                    child: Text(
                      "Перевести",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Divider(
                    color: Colors.white60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                    child: Text(
                      "Выставить счет",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Divider(
                    color: Colors.white60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                    child: Text(
                      "Удалить контакт",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget History() {
    Widget txItem(Tx tx) {
      bool status = tx.status == "Success" ? true : false;
      bool send = widget.contact.address == tx.data.sender ? true : false;
      Color color = status == false
          ? Colors.redAccent
          : send == true ? Colors.blue : Colors.greenAccent;
      IconData icon = status == false
          ? Icons.close
          : send == true ? Icons.arrow_upward : Icons.arrow_downward;
      String address = send ? tx.to : tx.from;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(34, 15, 45, .3),
                        blurRadius: 10,
                        offset: Offset(-2.5, 5))
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              icon,
                              color: color,
                              size: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0, left: 8),
                                  child: Text(
                                    InitWallet(address),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        InitBalace(tx.data.amount),
                                        style: TextStyle(
                                            color: color, fontSize: 18),
                                      ),
                                      Text(
                                        " DEL",
                                        style: TextStyle(
                                            color: color, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                txTimeParseDate(tx.timestamp),
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 16),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Text(
                                  txTimeParseTime(tx.timestamp),
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          print('project snapshot data is: ${projectSnap.data}');
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          );
        }
        return projectSnap.data.result.address.txs.length == 0
            ? SizedBox()
            : Column(
                children: List.generate(
                    projectSnap.data.result.address.txs.length, (index) {
                Tx tx = projectSnap.data.result.address.txs[index];
                return txItem(tx);
              }));
        // ListView.builder(
        //   itemCount: projectSnap.data.result.address.txs.length,
        //   itemBuilder: (context, index) {
        //     Tx tx = projectSnap.data.result.address.txs[index];
        //     return Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: <Widget>[
        //         Container(
        //             height: 30,
        //             child: Text(tx.from, style: TextStyle(color: Colors.white),))
        //       ],
        //     );
        //   },
        // );
      },
      future: GetUser(widget.contact.address, context),
    );
  }

  Widget Content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white60,
                radius: 70,
                child: Center(
                  child: Text(
                    widget.contact.name[0].toUpperCase(),
                    style: TextStyle(
                        color: Colors.black, fontFamily: "MPLUS", fontSize: 50),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(widget.contact.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "MPLUS",
                        fontSize: 30)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: panel(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: address(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: note(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            // child: events(),
          ),
          History(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
