class CheckCode{
  int code = 0;
  String token;
  CheckCode({this.code, this.token});
  factory CheckCode.fromJson(Map<String, dynamic> json){
    return CheckCode(
      code: json['code'],
      token: json['token'],
    );
  }



}