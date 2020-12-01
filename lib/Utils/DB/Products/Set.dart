import 'package:omega_qick/Utils/DB/Products/BlocSize.dart';


class SetBloc extends BlocSize{

  SetBloc({String name, String image, int route}) : super(name, 3, image, route);

  factory SetBloc.fromJson(Map<String, dynamic> json){

    return SetBloc(
      name: json['name'],
      image: json['image'],
      route: int.parse(json['route']),
    );
  }
}