
import 'package:integron/Utils/DB/auto.dart';
import 'package:integron/Utils/DB/codeDB.dart';
import 'package:integron/Utils/DB/tokenDB.dart';


Future<void> ExitAccount ()async {
  await autoDB(a: false);
  await codeDB(code: 0);
  await tokenDB(token: "null");
}