import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/Contacts/DataBase/DBConfig.dart';
import 'package:omega_qick/Utils/DB/WalletDB.dart';


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