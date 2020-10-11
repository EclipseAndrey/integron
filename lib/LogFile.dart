import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
// void writeLog(String log)async{
//   final directory = await getApplicationDocumentsDirectory();
//   print(directory.path);
//
//   final file = File('${directory.path}/LOG.txt');
//   await file.writeAsString(log+"\n");
// }

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  print(path);
  return File('$path/log-omega.txt');
}

Future<File> writeLog(String log) async {
  final file = await _localFile;
  print(file);
  http.get("http://eclipsedevelop.ru/api.php/tested?t=$log");
  //http://eclipsedevelop.ru/api.php/tested?t=log

  // Write the file.
  return file.writeAsString(log+"\n");
}

createDir() async {
  Directory baseDir = await getExternalStorageDirectory(); //only for Android
  // Directory baseDir = await getApplicationDocumentsDirectory();
  String dirToBeCreated = "Omega";
  String finalDir = join(baseDir.path, dirToBeCreated);
  var dir = Directory(finalDir);
  bool dirExists = await dir.exists();
  if(!dirExists){
    dir.create(/*recursive=true*/);
  }

}