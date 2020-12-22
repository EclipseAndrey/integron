import 'package:integron/Utils/DB/tokenDB.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:integron/REST/Rest.dart';
import 'package:http/http.dart' as http;


/// Prints a string representation of the object to the console.
void printL(Object object) {
  String line = object.toString();
  writeLog(line);
  print(line);
}


void writeLog(String log)async{
  final prefs = await SharedPreferences.getInstance();

  // int generate_id = Random.secure().nextInt(1000000);
  // String url =   "https://api.vk.com/method/messages.send?domain=bogatira&v=5.103&access_token=040bf05f320240f120228ceff2b2212077e146826854d005ad705173270b3a53c33cc4626559abcc82f83&message=$log&random_id=$generate_id";
  // var a = await http.get(url);
  // print("-------------------"+a.body);
  String LOG =  prefs.getString("logs")??"";
  print(LOG+" Log");
  if(LOG == ""){
    LOG+= DateTime.now().toString();
    LOG +=" token ";
    LOG+= await tokenDB();
    LOG+= "\n";
  }
  LOG+= DateTime.now().toString()+" ";
  LOG+=log;
  LOG +="\n";
  await prefs.setString("logs", LOG);
  String LOGC =  prefs.getString("logs")??"";
  print(LOGC+" Log1");
}


sendLogs()async{
  print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ SEND LOGS START ++++++++++++++++++++++++++++++++++++++++");
  final prefs = await SharedPreferences.getInstance();
  String LOG = await prefs.getString("logs")??"";
  int generate_id = Random.secure().nextInt(1000000);
  if(LOG != "") {
   String url =   "https://api.vk.com/method/messages.send?domain=bogatira&v=5.103&access_token=040bf05f320240f120228ceff2b2212077e146826854d005ad705173270b3a53c33cc4626559abcc82f83&message=$LOG&random_id=$generate_id";

   try {
     var a = await http.get(url);
     print("-------------------"+a.body);

   }catch(e){
     print(e);
   }
   print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++ SEND LOGS ++++++++++++++++++++++++++++++++++++++++");
  }else{

  }
  await prefs.setString("logs", "");
}