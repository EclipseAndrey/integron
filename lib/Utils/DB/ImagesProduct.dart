class ImageProduct{
  bool net;
  String path;
  ImageProduct(this.path, this.net);

  factory ImageProduct.fromJson(Map<String,dynamic> json){
    return ImageProduct(json['path'], json['net'] == null?false:json['net']);
  }
  Map<String,dynamic> toJson(){
    Map<String,dynamic> out = Map();
    out['path'] = path;
    out['net'] = net;
    return out;
  }

}