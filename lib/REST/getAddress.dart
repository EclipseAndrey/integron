import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:omega_qick/LogFile.dart';
import 'package:omega_qick/Parse/parseAddress.dart';



Future<AddressA> getAddress(String mnemonic, BuildContext context) async {

//    for debug
  AddressA address;
  //String numm = "dx19gt49xy8530wrewchjvrvgpm4r4wu3s25csr0a";

  String urlQuery = "http://194.226.171.139:10680/test.php?cmd=wallet.get&mnemonic=$mnemonic";
  writeLog("ADDRESS"+urlQuery);

  print("get Address "+urlQuery);
  var response;
  try {
   response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return address = null;
  }

  print("get Address "+response.body);
  void _processResponse(http.Response response) {
    if (response.statusCode == 200) {

      address =  AddressA.fromJson(json.decode(response.body));

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