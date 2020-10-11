import 'package:shared_preferences/shared_preferences.dart';

Future<bool> fingerDB ({bool f})async{
  final prefs = await SharedPreferences.getInstance();

  if(f == null){
    var f = await prefs.getBool("f")??false;
    return f;
  }else{
    await prefs.setBool("f",f);
  }
}