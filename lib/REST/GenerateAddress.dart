import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'file:///C:/Users/koren/AndroidStudioProjects/integron/lib/Utils/fun/LogFile.dart';
import 'package:omega_qick/Parse/parseAddress.dart';



Future<AddressA> generateAddress(BuildContext context) async {

//    for debug
  AddressA address;
  //String numm = "dx19gt49xy8530wrewchjvrvgpm4r4wu3s25csr0a";

  String urlQuery = "http://194.226.171.139:10680/test.php?cmd=wallet.create";

  writeLog("Create wallet"+urlQuery);
  print("Create Address "+urlQuery);

  var response = await http.get(urlQuery);

  writeLog("Create "+response.body);
  print("Create  "+response.body);


  void _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      address =  AddressA.fromJson(json.decode(response.body));
      print(response.body.toString());
      if(address.address == null|| address.mnemonic == null){
        address = null;
      }
    }else{
      address = null;
    }
  }
  _processResponse(response);
  return address;
}