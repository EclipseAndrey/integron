import 'package:integron/Utils/DB/Errors.dart';
import 'package:integron/Utils/DB/Put.dart';

class CheckCode extends Errors{
  int code = 0;
  String token;
  CheckCode({this.code, this.token});

  CheckCode.err(Put put){
    put = put;
  }
  factory CheckCode.fromJson(Map<String, dynamic> json){
    return CheckCode(
      code: json['code'],
      token: json['token'],
    );
  }
}