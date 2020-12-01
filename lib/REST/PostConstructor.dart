import 'package:omega_qick/REST/Server.dart';
import 'package:omega_qick/REST/Api.dart';

String postConstructor(String method){
  return Server.relevant+"/"+Api.api+"/"+method;
}