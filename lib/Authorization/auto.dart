import 'package:shared_preferences/shared_preferences.dart';

Future<bool> autoDB ({bool a})async{
  final prefs = await SharedPreferences.getInstance();

  if(a == null){
    var a = await prefs.getBool("a")??false;
    return a;
  }else{
    await prefs.setBool("a",a);
  }
}