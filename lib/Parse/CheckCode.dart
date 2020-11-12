import 'package:omega_qick/Errors.dart';

class CheckCode extends Errors{
  String code = "0";
  String token;
  CheckCode({this.code, this.token});

  CheckCode.err(){
    error = true;
  }
  factory CheckCode.fromJson(Map<String, dynamic> json){
    return CheckCode(
      code: json['code'],
      token: json['token'],
    );
  }
}