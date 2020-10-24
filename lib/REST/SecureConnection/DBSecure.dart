import 'package:shared_preferences/shared_preferences.dart';

import 'DataSecure.dart';

Future<DataSecure> DataSecureDB({DataSecure dataSecure})async{
  final prefs = await SharedPreferences.getInstance();
  if(dataSecure != null ){
    prefs.setString("text", dataSecure.text);
    prefs.setInt("key", dataSecure.key);
  }else{
    String textDB = prefs.getString("text")??"null";
    int keyDB = prefs.getInt("key")??0;
    return DataSecure(keyDB,textDB);
  }
}