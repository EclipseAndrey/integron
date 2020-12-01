import 'package:omega_qick/Utils/DB/tokenDB.dart';
import 'package:shared_preferences/shared_preferences.dart';



void writeLog(String log)async{
  final prefs = await SharedPreferences.getInstance();

  String LOG = await prefs.getString("LOG")??"";
  if(LOG == ""){
    LOG+= DateTime.now().toString();
    LOG +=" token ";
    LOG+= await tokenDB();
  }
  LOG+= DateTime.now().toString()+" ";
  LOG+=log;
  LOG +="\n";
  await prefs.setString("LOG", LOG);
}


sendLogs()async{
  final prefs = await SharedPreferences.getInstance();
  String LOG = await prefs.getString("LOG")??"";

  if(LOG != "") {
    //todo Send logs
  }else{

  }
  await prefs.setString("LOG", "");
}