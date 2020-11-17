import 'package:omega_qick/Errors.dart';

class Property extends EditPropertyFlags{
  String value = "";
  String name = "";
  Property({this.name,this.value, bool editingValue, bool editingName, bool canDelete}): super(editingValue: editingValue??true, editingName: editingName??true, canDelete:canDelete??true);
  factory Property.fromJson(Map<String, dynamic> json){
    return Property(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map["name"] = name;
    map["value"] = value;
    return map;
  }
}