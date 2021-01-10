import 'dart:convert';
import 'package:integron/Utils/DB/ImagesProduct.dart';
import 'package:integron/Utils/DB/Products/Params/Params.dart';
import 'package:integron/Utils/DB/Products/Property.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:integron/Utils/DB/Products/Params/Param.dart';
part 'DraftTable.dart';

class DraftDB {
  static Future<void> clean() async {
    print('DRAFT CLEAN');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(DraftTable.images, null);
    await prefs.setString(DraftTable.unit, null);
    await prefs.setInt(DraftTable.type, null);
    await prefs.setStringList(DraftTable.property, null);
    await prefs.setInt(DraftTable.delivery, null);
    await prefs.setString(DraftTable.address, null);
    await prefs.setString(DraftTable.fullText, null);
    await prefs.setString(DraftTable.shortText, null);
    await prefs.setInt(DraftTable.category, null);
    await prefs.setStringList(DraftTable.details, null);
    await prefs.setStringList(DraftTable.params, null);
    await prefs.setString(DraftTable.accountName, null);
    await prefs.setString(DraftTable.accountSecretKey, null);
    await prefs.setString(DraftTable.offerCode, null);
    await prefs.setString(DraftTable.name, null);
    await prefs.setString(DraftTable.price, null);
    await prefs.setBool(DraftTable.table, false);
  }

  static Future<void> set({
    List<String> images,
    String unit,
    int type,
    List<Property> property,
    int delivery,
    String address,
    String fullText,
    String shortText,
    int category,
    List<ImageProduct> details,
    List<Params> params,
    String accountName,
    String accountSecretKey,
    String offerCode,
    String name,
    String price,
  }) async {
    print('DRAFT SET');
    if(
    images == null && unit == null && type == null && property == null &&
        delivery == null && address == null && fullText == null && shortText == null &&
        category == null && details == null && params == null && accountName == null &&
        accountSecretKey == null && offerCode == null && name == null && price == null
    ){
      print('set is empty');
      return;}

    final prefs = await SharedPreferences.getInstance();

    if(images != null){
      await prefs.setStringList(DraftTable.images, images);
      await prefs.setBool(DraftTable.table, true);
    }
    if(unit != null){
      await prefs.setString(DraftTable.unit, unit);
      await prefs.setBool(DraftTable.table, true);
    }
    if(type != null){
      await prefs.setInt(DraftTable.type, type);
      await prefs.setBool(DraftTable.table, true);
    }
    if(property != null){
      await prefs.setStringList(DraftTable.property, property.map((e) => jsonEncode(e.toJson())).toList().cast<String>());
      await prefs.setBool(DraftTable.table, true);
    }
    if(delivery != null){
      await prefs.setInt(DraftTable.delivery, delivery);
      await prefs.setBool(DraftTable.table, true);
    }
    if(address != null){
      await prefs.setString(DraftTable.address, address);
      await prefs.setBool(DraftTable.table, true);
    }
    if(fullText != null){
      await prefs.setString(DraftTable.fullText, fullText);
      await prefs.setBool(DraftTable.table, true);
    }
    if(shortText != null){
      await prefs.setString(DraftTable.shortText, shortText);
      await prefs.setBool(DraftTable.table, true);
    }
    if(category != null){
      await prefs.setInt(DraftTable.category, category);
      await prefs.setBool(DraftTable.table, true);
    }
    if(details != null){
      await prefs.setStringList(DraftTable.details, details.map((e) => jsonEncode(e.toJson())).toList().cast<String>());
      await prefs.setBool(DraftTable.table, true);
    }
    if(params != null){
      await prefs.setStringList(DraftTable.params, params.map((e) => jsonEncode(e.toJson())).toList().cast<String>());
      await prefs.setBool(DraftTable.table, true);
    }
    if(accountName != null){
      await prefs.setString(DraftTable.accountName, accountName);
      await prefs.setBool(DraftTable.table, true);
    }
    if(accountSecretKey != null){
      await prefs.setString(DraftTable.accountSecretKey, accountSecretKey);
      await prefs.setBool(DraftTable.table, true);
    }
    if(offerCode != null){
      await prefs.setString(DraftTable.offerCode, offerCode);
      await prefs.setBool(DraftTable.table, true);
    }
    if(name != null){
      await prefs.setString(DraftTable.name, name);
      await prefs.setBool(DraftTable.table, true);
    }
    if(price != null){
      await prefs.setString(DraftTable.price, price.toString());
      await prefs.setBool(DraftTable.table, true);
    }
    return;
  }

  static Future<Map<String, dynamic>> get ()async{
    print('DRAFT GET');
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> out = Map();
    out[DraftTable.table] = prefs.getBool(DraftTable.table)??false;
    print(prefs.getBool(DraftTable.table)??false);
    if(out[DraftTable.table] == false) {return null;}
    out[DraftTable.images] = prefs.getStringList(DraftTable.images);//
    out[DraftTable.unit] = prefs.getString(DraftTable.unit);//
    out[DraftTable.type] = prefs.getInt(DraftTable.type);
    out[DraftTable.property] = prefs.getStringList(DraftTable.property)== null?null:prefs.getStringList(DraftTable.property).map((e) => Property.fromJson(jsonDecode(e))).toList().cast<Property>();
    out[DraftTable.delivery] =  prefs.getInt(DraftTable.delivery);//
    out[DraftTable.address] = prefs.getString(DraftTable.address);//
    out[DraftTable.fullText] = prefs.getString(DraftTable.fullText);//
    out[DraftTable.shortText] = prefs.getString(DraftTable.shortText);//
    out[DraftTable.category] = prefs.getInt(DraftTable.category);//
    out[DraftTable.details] = prefs.getStringList(DraftTable.details) == null?null:prefs.getStringList(DraftTable.details).map((e) => ImageProduct.fromJson(jsonDecode(e))).toList().cast<ImageProduct>();
    out[DraftTable.params] = prefs.getStringList(DraftTable.params) == null?null:prefs.getStringList(DraftTable.params).map((e) => Params.fromJson(jsonDecode(e))).toList().cast<Params>();
    out[DraftTable.accountName] = prefs.getString(DraftTable.accountName);//
    out[DraftTable.accountSecretKey] = prefs.getString(DraftTable.accountSecretKey);//
    out[DraftTable.offerCode] = prefs.getString(DraftTable.offerCode);//
    out[DraftTable.name] = prefs.getString(DraftTable.name);//
    out[DraftTable.price] = prefs.getString(DraftTable.price);//
    return out;
  }

  static Future<void> testDraft()async{
    print('start test');
    try {
      clean();
      print('clean ok');
    }catch(e){
      print('error clean');
      return;
    }
    try{
      await set(images: ['image 1', 'image 2'], params: [Params(name: 'Params one', params: [Param(name: 'name')])], property: [Property(name: "Name property", value: "Value property")]);
      print('set ok');
    }catch(e){
      print(e);
      print('error set');
      return;
    }
    try{
      Map<String,dynamic> out = await get();
      print('get ok');
    }catch(e){
      print(e);
      print('error get');
      return;
    }
    try{
      Map<String,dynamic> out = await get();
      Params param = out[DraftTable.params][0];
      if(param.name == 'Params one'){
        print('result ok');
      }else{
        print('error result if');
      }
    }catch(e){
      print(e);
      print('error result catch');
    }
  }

  static Future<bool>  isEmpty () async{
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getBool(DraftTable.table));
    return !(prefs.getBool(DraftTable.table)??false);
  }

}
