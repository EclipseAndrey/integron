import 'dart:convert';
import 'dart:math';
import 'dart:convert' show utf8;
import 'package:omega_qick/REST/SecureConnection/AUTH_1.dart';
import 'package:omega_qick/REST/SecureConnection/DBSecure.dart';
import 'package:omega_qick/REST/SecureConnection/DataSecure.dart';
import 'package:omega_qick/REST/SecureConnection/dataAuth1.dart';
import 'package:omega_qick/REST/SecureConnection/dataAuth2.dart';

import 'AUTH_2.dart';

class Connection{

  Connection._();
  static final Connection secure = Connection._();
  static DataSecure _key;
  Future<DataSecure> get key async{
    if(_key != null) return _key;
    _key = await _createKey();
    return _key;
  }

  Future<DataSecure> _createKey()async{

    DataSecure dataSecure = await DataSecureDB();

    if(dataSecure.text == "null"|| dataSecure.key == 0){
      const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random _rnd = Random();

      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


      String text = getRandomString(100);


      int privte = Random().nextInt(1000000)+1; //346
      int public = Random().nextInt(1000000)+1;  // 58


      DataAuth1 dataAuth1= await Auth_1(public, text);

      int part = dataAuth1.pubKey.modPow(privte, public); //58^346%43

      // part server = 43^279%58 = 27

      int fullKey = dataAuth1.partKey.modPow(privte, public); // 27^346%43  = 17

      // full server = 25^279%58
      print("private = $privte public = $public publicServer = ${dataAuth1.pubKey} part = $part partServer = ${dataAuth1.partKey} fullKey = $fullKey");



      DataAuth2 dataAuth2 = await Auth_2(part, text, public);


      DataSecureDB(dataSecure: DataSecure(fullKey,text));

      return DataSecure(fullKey,text);
    }else{
      return dataSecure;
    }

  }

  // 32...127


  void checkUnitCode(String output){
    String check = "";
    for(int i = 0;i < output.length;i++ ){
      check += output.codeUnitAt(i).toString() +" ";
    }
    print( check);
  }

  Future<List<int>> crypto(String text)async{
    String output = "";
    int all = 65536;

    checkUnitCode(text);

    DataSecure data = await this.key;
    int keyS =  data.key;
    int key = data.key;

    for(int i = 0; i < text.length; i ++){
      if(i > 0){key = output[i-1].codeUnitAt(0)+keyS;}
      int step = (text[i].codeUnitAt(0) + key)%all;
      key %= all;
      if(key%all == 0 ) key = all;
      output +=  String.fromCharCode(step);
    }
    print("key "+ keyS.toString());
    checkUnitCode(output);


    List<int> outputInt = [];
    for(int i  = 0; i < output.length; i++){
      outputInt.add(output.codeUnitAt(i));
    }


    return outputInt;
  }
  Future<String> reCrypto(List<dynamic> array)async{

    String text = "";

    for(int i = 0; i < array.length; i++){
      text += String.fromCharCode(array[i]);
    }

    checkUnitCode(text);

    try {
      Utf8Decoder decode = new Utf8Decoder();
      List<int> array = [];
      for (int i = 0; i < text.length; i++) {
        array.add(text.codeUnitAt(i));
      }

      text = decode.convert(array);
      checkUnitCode(text);
    }catch(e){

    }

    String output = "";
    int all = 65536;
    int step =0;
    DataSecure data = await this.key;
    print("reCryoto key ${data.key} text ${data.text}");
    int keyS =  data.key;
    int key = data.key;

    for(int i = 0; i < text.length; i ++){
      if(i > 0){ key = text[i-1].codeUnitAt(0)+keyS;
      }

      step = text[i].codeUnitAt(0) - key;
      while(step < 0)step += all;
      key %= all;
      if(key%all == 0 ) key = all;
      output +=  String.fromCharCode(step);
    }
    checkUnitCode(output);
    print(output);
    return output;
  }





}