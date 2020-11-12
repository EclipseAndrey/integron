import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/fun/LogFile.dart';
import 'package:omega_qick/Parse/parseAddress.dart';

import '../JsonParse.dart';


Future<User> GetUser(String address, BuildContext context) async {

//    for debug
  User _user;
  //String numm = "dx19gt49xy8530wrewchjvrvgpm4r4wu3s25csr0a";

  String urlQuery = "https://mainnet-gate.decimalchain.com/api/address/$address?txLimit=100";

  print(urlQuery);

  var response = await http.get(urlQuery);
  print(response.body);
  void _processResponse(http.Response response) {
    print(response.body.toString()+"=======");
    if (response.statusCode == 200) {
      _user =  User.fromJson(json.decode(response.body));
      print(response.body.toString());
    }
  }
  _processResponse(response);
  return _user;
}

Future<List<User>> GetUsers(List<AddressA> addresses, BuildContext context) async {
  List<User> users = [];
  for(int i = 0; i < addresses.length; i++) {
    String address = addresses[i].address;
    String urlQuery = "https://mainnet-gate.decimalchain.com/api/address/$address?txLimit=100";
    print(urlQuery);
    try{
      var response = await http.get(urlQuery);
      if(response.statusCode == 200){
        users.add(User.fromJson(json.decode(response.body)));
        print(response.body);
      }else{
        users.add(User.error());
      }
    }catch(e){
      users.add(User.error());
    }
  }
  return users;
}








































