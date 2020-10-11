import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../JsonParse.dart';


Future<User> getUser(String address, BuildContext context) async {

//    for debug
  User _user;
  //String numm = "dx19gt49xy8530wrewchjvrvgpm4r4wu3s25csr0a";

  String urlQuery = "https://mainnet-gate.decimalchain.com/api/address/$address?txLimit=10";
  print(urlQuery);
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)
            ),

          ),
          width: 0,
          height: 80,
          child: Center(
            child: new CircularProgressIndicator(
              backgroundColor: Colors.purple,
            ),
          ),
        ),

      );
    },
  );
  var response;
  try {
    response = await http.get(urlQuery);
  }catch(e){
    _user = null;
    return _user;
  }
  print(response.body);
  void _processResponse(http.Response response) {
    print(response.body.toString()+"=======");
    if (response.statusCode == 200) {
      _user =  User.fromJson(json.decode(response.body));
      print(response.body.toString());
    }
    else _user = null;
  }
  _processResponse(response);
  Navigator.of(context).pop();
  return _user;
}