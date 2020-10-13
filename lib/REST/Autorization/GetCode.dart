import 'package:http/http.dart' as http;

Future<int> GetCode (String num)async{
  String urlQuery = "";
  print(urlQuery);
  var response;
  try{
    response = await http.get(urlQuery).timeout(Duration(seconds: 5));
  }catch(e){
    return null;
  }
  print("getCode "+response.body);
  if(response.statusCode == 200){
    return response.body['code'];
  }else{
    return null;
  }
}