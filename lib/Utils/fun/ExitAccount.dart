
import 'package:omega_qick/Utils/DB/auto.dart';
import 'package:omega_qick/Utils/DB/codeDB.dart';
import 'package:omega_qick/Utils/DB/tokenDB.dart';


Future<void> ExitAccount ()async {
  await autoDB(a: false);
  await codeDB(code: 0);
  await tokenDB(token: "null");
}