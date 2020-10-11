import 'package:flutter/material.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';

Widget address(Contact contact, BuildContext context) {
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
                child: Text(contact.address,
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