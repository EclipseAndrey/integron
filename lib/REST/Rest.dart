import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:integron/REST/SecureConnection/Connection.dart';
import 'package:integron/Utils/DB/Put.dart';
import 'package:flutter/services.dart';

bool secureDefault = true;

class Rest {
  Rest._();
  Rest rest = Rest._();
  static Future<dynamic> post (String url, Map<String,dynamic> body, {bool secure, bool secureUp, bool secureDown})async{
    print("post url "+url);
    print("post body "+body.toString());
    secure = secure??secureDefault;
    var key = await Connection.secure.key;
    String text = key.text;
    if((secureUp != null  && secureUp == true)||(secure && secureUp == null)){
      Map<String,dynamic> bodyUp = Map<String,dynamic>();
      bodyUp['text'] = text;
      bodyUp['body'] = await Connection.secure.crypto(json.encode(body));
      body = bodyUp;
      print("post body crypto "+body.toString());
      // Clipboard.setData(ClipboardData(text: json.encode(body)));
    }

    Map<String, String> headers =  HashMap();
    headers['Content-type'] = 'application/json';
    var response;
    response = await http.post(url, encoding: Encoding.getByName('utf-8'), body: json.encode(body), headers: headers);
    print("response "+url+ "  ${response.statusCode}  "+response.body  );
    if(response.statusCode == 200){

        if((secureDown !=null && secureDown == true)||(secure && secureDown == null)){
          var res = jsonDecode(await Connection.secure.reCrypto(json.decode(response.body)));
          //print("decrypto "+res.toString());
          print("++++++++++++++++++++++++++++++++++++++++++++++++++c"+res.toString());

          if(res['code'] == 200){
            return res;
          }else{
            return Put(error: res['code'], mess: res['mess'], localError: true);
          }
        }else{
          var res = jsonDecode(response.body);
          print("++++++++++++++++++++++++++++++++++++++++++++++++++f"+res.toString());
          //print("response body "+res.toString());

          if(res['code'] == 200){
            print("res");
            return res;
          }else{
            print("put");

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

