import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omega_qick/REST/SecureConnection/Connection.dart';
import 'package:omega_qick/Utils/DB/Put.dart';


bool secureDefault = true;

class Rest {
  Rest._();
  Rest rest = Rest._();
  static Future<dynamic> post (String url, Map<String,dynamic> body, {bool secure})async{
    print("post url "+url);
    print("post body "+body.toString());
    secure = secure??secureDefault;
    var key = await Connection.secure.key;
    String text = key.text;
    if(secure){
      Map<String,dynamic> bodyUp = Map<String,dynamic>();
      bodyUp['text'] = text;
      bodyUp['body'] = await Connection.secure.crypto(json.encode(body));
      body = bodyUp;
      print("post body crypto "+body.toString());
    }

    Map<String, String> headers =  HashMap();
    headers['Content-type'] = 'application/json';
    var response;
    response = await http.post(url, encoding: Encoding.getByName('utf-8'), body: json.encode(body), headers: headers);
    print("response "+url+ "   "+response.body  );
    if(response.statusCode == 200){
      if(secure){
        var res = jsonDecode(await Connection.secure.reCrypto(json.decode(response.body)));
        //print("decrypto "+res.toString());
        if(res['code'] == 200){
          return res;
        }else{
          return Put(error: res['code'], mess: res['mess'], localError: true);
        }
      }else{
        var res = jsonDecode(response.body);
        //print("response body "+res.toString());

        if(res['code'] == 200){
          return res;
        }else{
          return Put(error: res['code'], mess: res['mess'], localError: true);
        }
      }
    }else{
      return Put(error: response.statusCode, localError: false, mess: "");
    }
  }

  static Future<dynamic> get (String url)async{
    print("get url "+url);
    try {
      var response = await http.get(url);
      if(response.statusCode == 200){
        var dec = json.decode(response.body);
        //print("get response "+ dec.toString());

        if(dec['code'] !=200){
          return Put(localError: true, mess: dec['mess'], error: dec['code']);
        }else{
          return dec;
        }
      }else{
        return Put(localError: false, mess: "", error: response.statusCode);
      }
    }catch(e){
      return Put(mess: e.toString(), localError: true, error: 1000);
    }

  }
}

