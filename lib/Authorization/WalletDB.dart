import 'dart:io';

import 'package:omega_qick/Authorization/Cri/AdderABC.dart';
import 'package:omega_qick/Authorization/DBConfig.dart';
import 'package:omega_qick/Contacts/DataBase/DBConfig.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WalletData {
  int id;
  String seed;
  String address;
  bool main;

  WalletData(this.seed,this.address);


  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map[walletsSeed] = seed;
    map[walletsAddress] = address;
    return map;
  }

  WalletData.fromMap(Map<String, dynamic> map) {
    id = map[walletsId];
    seed = reCrypto(map[walletsSeed],map[walletsAddress]);
    address = map[walletsAddress];

  }
  WalletData.fromJson(Map<String, dynamic> json){
    seed = reCrypto(json['seed'],json['address']);
    address = json['address'];
    main = json[main];
  }


}



class DBProvider{
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;

    _database  = await _initDB();
    return _database;
  }

  Future<Database> _initDB()async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path  = dir.path+"base.db";
    return await openDatabase(path, version: 2, onCreate : _createDB);
  }

  void _createDB (Database db, int version)async{
    await db.execute('CREATE TABLE $tableWallets ( $walletsId INTEGER PRIMARY KEY AUTOINCREMENT, $walletsSeed TEXT, $walletsAddress TEXT)',);
    await db.execute('CREATE TABLE $tableContacts ( $contactsId INTEGER PRIMARY KEY AUTOINCREMENT, $contactsName TEXT,$contactsNum TEXT, $contactsAddress TEXT, $contactsPhoto TEXT, $contactsPriory INT)',);
  }

  Future<List<WalletData>> WalletDB ({WalletData walletData})async{


    if(walletData != null) {
      walletData.seed = crypto(walletData.seed, walletData.address);
      Database db = await this.database;
      print("connect Base ok");
      walletData.id = await db.insert(tableWallets, walletData.toMap());
      print("insert walletData ${walletData.id}");
    }
    else {
      print("get Wallet DB");
      Database db = await this.database;
      final List<Map<String,dynamic>> NotesMapList = await db.query(tableWallets);
      final List<WalletData> WalletDataList = [];
      NotesMapList.forEach((element) {
        WalletDataList.add(WalletData.fromMap(element));
      });
      // for(int i = 0; i < WalletDataList.length; i++){
      //   WalletDataList[i].seed = reCrypto(WalletDataList[i].seed, WalletDataList[i].address);
      // }

      return WalletDataList;
    }
  }

  Future<bool> DeleteWallets ()async{
    Database db = await this.database;
    print("delete wallets");
    await db.delete(tableWallets);
    return true;
  }





}


