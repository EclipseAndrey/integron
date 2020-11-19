
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> sendPhoto (String filename) async {

  String url = "http://194.226.171.139:14880/apitest.php/uploadPhoto";

  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.files.add(
      http.MultipartFile(
          'var_file',
          File(filename).readAsBytes().asStream(),
          File(filename).lengthSync(),
          filename: filename.split("/").last
      )
  );
  var res = await request.send();
  //     .then((value){
  //
  // });
  //print("req "+ res.request.toString());

  res.stream.transform(utf8.decoder).listen((value) {
    print(value);
    return json.decode(value)['url'];
  });

}