import 'package:flutter/material.dart';
import 'package:omega_qick/AutoRoutes.dart';
import 'package:omega_qick/ToolsPanel/BuildBillDialog.dart';
import 'package:omega_qick/Utils/DB/WalletDB.dart';
import 'package:omega_qick/Utils/DB/auto.dart';
import 'package:omega_qick/Utils/DB/codeDB.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:omega_qick/main.dart';

Future<void> ExitAccount ()async {
  await autoDB(a: false);
  await codeDB(code: 0);
  await tokenDB(token: "null");
  await DBProvider.db.DeleteWallets();
}