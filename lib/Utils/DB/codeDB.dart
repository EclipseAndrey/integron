import 'package:shared_preferences/shared_preferences.dart';

Future<int> codeDB ({int code})async{
  final prefs = await SharedPreferences.getInstance();

  if(code == null){
    var code = await prefs.getInt("code")??0;
    return code;
  }else{
    await prefs.setInt("code",code);
  }
}