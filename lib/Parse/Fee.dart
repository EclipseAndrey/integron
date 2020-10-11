class Fee {
  String gasUsed;
  Fee({this.gasUsed});
  factory Fee.fromJson(Map<String, dynamic> json){
    return Fee(
      gasUsed: json['gas_used'] == null? "": json['gas_used'],
    );
  }
}