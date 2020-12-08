import 'package:integron/REST/Server.dart';
import 'package:integron/REST/Api.dart';

String postConstructor(String method){
  return Server.relevant+"/"+Api.api+"/"+method;
}