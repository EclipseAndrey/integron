import 'package:omega_qick/Authorization/WalletDB.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/Contacts/DataBase/DBConfig.dart';

Future<Contact> getContactForAddress(String address)async{
  var db = await DBProvider.db.database;

  final List<Map<String,dynamic>> ContactsMapList = await db.query(tableContacts, where: "$contactsAddress =?", whereArgs: [address]);
  final List<Contact> ContactsList = [];
  ContactsMapList.forEach((element) {
    ContactsList.add(Contact.fromMap(element));
  });
  if(ContactsList.length > 0){return ContactsList[0];}else{
    return Contact.error();
  }
}