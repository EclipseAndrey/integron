import 'package:flutter/material.dart';
import 'package:omega_qick/Contacts/DataBase/AddContacts.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/Contacts/DataBase/DBDeleteContacts.dart';
import 'package:omega_qick/Contacts/Pages/ContactInfo/Panel.dart';
import 'package:omega_qick/Contacts/SendToContact/SendToContact.dart';
import 'package:omega_qick/JsonParse.dart';
import 'package:omega_qick/Parse/parseAddress.dart';
import 'package:omega_qick/REST/GetUser.dart';
import 'package:omega_qick/REST/getWalletR.dart';
import 'package:omega_qick/Style.dart';
import 'package:omega_qick/ToolsPanel/DepositDialog.dart';
import 'package:omega_qick/Utils/DB/WalletDB.dart';
import 'package:omega_qick/Utils/fun/DialogLoading/DialogLoading.dart';
import 'package:share/share.dart';
import 'AddContactContent/AddContactController.dart';
import 'ContactInfo/Address.dart';
import 'ContactInfo/History.dart';
import 'ContactInfo/Note.dart';

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
            child: Panel(widget.contact),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: address(widget.contact, context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: note(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            // child: events(),
          ),
          History(widget.contact, context),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
