import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> uploadPhoto (String filename, String url) async {
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

  if(res.statusCode != 200)return null;
  res.stream.transform(utf8.decoder).listen((value) {
    print(value);

    return json.decode(value)['url'];
  });

}