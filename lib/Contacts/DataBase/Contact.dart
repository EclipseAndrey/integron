import 'package:omega_qick/Contacts/DataBase/DBConfig.dart';

class Contact {
  int id;
  String address;
  String name;
  String photo;
  int priory;
  String num;
  bool errors = false;


  Contact(this.id, this.name, this.address,this.photo, this.priory, this.num);
  Contact.error(){
    errors = true;
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map[contactsAddress] = address;
    map[contactsPriory] = priory;
    map[contactsPhoto] = photo;
    map[contactsName] = name;
    map[contactsNum] = num;
    return map;
  }
  Contact.fromMap(Map<String, dynamic> map){
    address = map[contactsAddress];
    priory = map[contactsPriory];
    photo = map[contactsPhoto];
    name = map[contactsName];
    num = map[contactsNum];
    id = map[contactsId];
  }

}
