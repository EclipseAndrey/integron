import 'package:omega_qick/Authorization/WalletDB.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/Contacts/DataBase/DBConfig.dart';


Future<List<Contact>> getContacts({int id})async{
  var db = await DBProvider.db.database;

  final List<Map<String,dynamic>> ContactsMapList = await db.query(tableContacts);
  final List<Contact> ContactsList = [];
  ContactsMapList.forEach((element) {
    ContactsList.add(Contact.fromMap(element));
  });
  if(ContactsList.length > 0){return ContactsList;}else{
    return [];
  }
}