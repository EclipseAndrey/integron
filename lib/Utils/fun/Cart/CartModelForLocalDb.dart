class CartModel{
  int id;
  int count;
  List<int> params;
  CartModel({this.count,this.id, this.params});

  factory CartModel.fromJson(Map<String,dynamic> map){
    return CartModel(
      id: map['id'],
      count: map['count'],
      params: map['params'].map((e) => e).toList().cast<int>()
    );
  }

  Map<String, dynamic> toJson(){
    Map<String,dynamic> map = Map();
    map['id'] = id;
    map['count'] = count;
    map['params'] = params;
    return map;
  }
}