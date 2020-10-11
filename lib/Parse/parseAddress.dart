

class AddressA {
  String address;
  String mnemonic;
  AddressA({this.address, this.mnemonic});
  factory AddressA.fromJson(Map<String, dynamic> json){
    return AddressA(
      address: json['address'],
      mnemonic: json['mnemonic'],
    );
  }
}