import 'package:flutter/material.dart';
import 'package:omega_qick/Parse/tx.dart';
import 'package:omega_qick/Parse/txs.dart';

import '../../JsonParse.dart';
import 'ItemList.dart';

List<Widget>ListHistory(List<dynamic> txs, User user){
  List<Widget> h = [];
  List.generate(txs.length, (index) {
    print("generate");
    h.add(itemListHistory(txs[index], user),);
  });
  return h;
}