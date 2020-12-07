import 'package:omega_qick/Utils/DB/Errors.dart';
import 'package:omega_qick/Utils/DB/Put.dart';
import 'package:omega_qick/Utils/fun/InitBalance.dart';

class Balance extends Errors{
  double balance;
  String address;

  Balance({this.address,this.balance});

  Balance.err(Put put):super(put: put);

  factory Balance.fromJson(Map<String, dynamic> json){

    /// парсинг динамического типа
    double balParse(Map<String,dynamic> map){
      try{
        return double.parse(map['balance']);
      }catch(e){
        try {
          return int.parse(map['balance']).toDouble();
        }catch(e){
          return 0;
        }
      }
    }
    return Balance(
      address: json['address']== null?"":json['address'],
      balance: balParse(json),
    );
  }


}