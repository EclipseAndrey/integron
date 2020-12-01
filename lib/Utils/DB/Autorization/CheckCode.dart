import 'package:omega_qick/Utils/DB/Errors.dart';
import 'package:omega_qick/Utils/DB/Put.dart';

class CheckCode extends Errors{
  String code = "0";
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