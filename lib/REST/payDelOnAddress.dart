import 'package:http/http.dart' as http;

import '../reqests.dart';



Future<String> sendDel(String seed, String address, String summ)async{
  var a = await http.get(SendDel(seed,address,summ));
  print(a.body);
  return "ok";
}