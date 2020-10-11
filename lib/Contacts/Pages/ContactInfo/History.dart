import 'package:flutter/material.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/InitBalance.dart';
import 'package:omega_qick/InitWallet.dart';
import 'package:omega_qick/Parse/tx.dart';
import 'package:omega_qick/REST/GetUser.dart';
import 'package:omega_qick/TimeParse.dart';

Widget History(Contact contact, BuildContext context) {
  Widget txItem(Tx tx) {
    bool status = tx.status == "Success" ? true : false;
    bool send = contact.address == tx.data.sender ? true : false;
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
    future: GetUser(contact.address, context),
  );
}