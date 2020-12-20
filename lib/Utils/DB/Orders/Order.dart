import 'package:integron/Utils/DB/Products/Product.dart';

class Order {
  int clientId;
  int id;
  String clientNum;
  List<Product> products;
  int status;
  int ownerId;
  String comment;
  double summ;
  List<String> paramsString;
  int count;
  String time;
  String bizName;

  Order({
    this.comment,
    this.count,
    this.status,
    this.summ,
    this.id,
    this.clientId,
    this.clientNum,
    this.ownerId,
    this.paramsString,
    this.products,
    this.time,
    this.bizName
});
  factory Order.fromJson(Map<String, dynamic> json){
    print("BIZ PARSE ${json['ownername']}");
    return Order(
      comment: json['comment']== null?"":json['comment'],
      count: json['count'] == null?0:int.parse(json['count']),
      status: json['status']== null?0:int.parse(json['status']),
      summ: json['sum']== null?0.0:double.parse(json['sum']),
      id: json['id']== null?0:int.parse(json['id']),
      clientId: json['client']== null?0:int.parse(json['client']),
      clientNum: json['clientnum'] == null?"null":json['clientnum'],
      bizName: json['ownername'] == null?"null":json['ownername'],
      ownerId: json['owner']== null?0:int.parse(json['owner']),
      paramsString: json['params'] == null?[]:json['params'].map((i)=>i).toList().cast<String>(),
      products:  json['items'] == null?[]:json['items'].map((i)=>Product.fromJson(i)).toList().cast<Product>(),
      time: json['time'] == null? "2020-11-18 15:58:50":json['time'],
    );
  }
}