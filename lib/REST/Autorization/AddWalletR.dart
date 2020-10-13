import 'package:omega_qick/REST/Servers.dart';
import 'package:http/http.dart' as http;

Future<int> AddWalletR (bool main, String seed, String address)async{
  String mainR = main?"1":"0";
  String urlQuery = serverBD+ "/api.php/setname?main=$mainR&seedphrase=$seed&address=$address";
  print(urlQuery);
  var response;
  try{
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("AddWallet "+response.body);
  if(response.statusCode == 200){
    return response.body['code'];
  }else{
    return null;
  }
}