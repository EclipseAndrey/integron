class CategoryPath{
  int id;
  int parent;
  String image;
  String name;

  CategoryPath({this.name,this.image,this.id,this.parent});

  factory CategoryPath.fromJson(Map<String, dynamic> json){
    return CategoryPath(
      id: int.parse(json['id']),
      parent: int.parse(json['parent']),
      image: json['image'],
      name: json['name'],
    );
  }

}