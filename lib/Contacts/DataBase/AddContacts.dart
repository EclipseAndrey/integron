import 'package:omega_qick/Authorization/WalletDB.dart';
import 'package:omega_qick/Contacts/DataBase/Contact.dart';
import 'package:omega_qick/Contacts/DataBase/DBConfig.dart';
import 'package:omega_qick/Contacts/DataBase/GetContactForAddress.dart';

Future<bool> AddContact(Contact contact)async{
  var db = await DBProvider.db.database;
  if(!contact.errors){
    print("insertContact");
    final List<Map<String,dynamic>> ContactsMapList = await db.query(tableContacts, where: "$contactsAddress = ?", whereArgs: [contact.address]);
    final List<Contact> ContactsList = [];
    ContactsMapList.forEach((element) {
      ContactsList.add(Contact.fromMap(element));
    });
    if(ContactsList.length>0){return false;}else{
      await db.insert(tableContacts, contact.toMap());
      return true;
    }
  }else{
    return false;
  }

}