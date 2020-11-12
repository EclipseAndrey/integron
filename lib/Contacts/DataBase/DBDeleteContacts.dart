import 'package:omega_qick/Utils/DB/WalletDB.dart';
import 'package:sqflite/sqflite.dart';

import 'DBConfig.dart';

Future<bool> deleteContacts({int id, String address})async{
  Database db = await DBProvider.db.database;
  if(id != null){
    print("Delete contact $id");
    await db.delete(tableContacts, where: "$contactsId =?", whereArgs: [id]);
    return true;
  }else if(address != null){
    print("Delete contact $address");
    await db.delete(tableContacts, where: "$contactsAddress =?", whereArgs: [address]);
    return true;

  }else{
    print("Delete all contacts");
    await db.delete(tableContacts);
    return true;
  }
}