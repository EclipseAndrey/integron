class Methods{
  bool post;
  String name;
  List<Params> params;
  List<Codes> codes;

  Methods({this.post, this.name, this.params, this.codes});

  factory Methods.fromMap(Map<String, dynamic> map) {
    return new Methods(
      post: map['post'] as bool,
      name: map['name'] as String,
      params: map['params'] as List<Params>,
      codes: map['codes'] as List<Codes>,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'post': this.post,
      'name': this.name,
      'params': this.params.map((e) => e.toMap()).toList(),
      'codes': this.codes.map((e) => e.toMap()).toList(),
    } as Map<String, dynamic>;
  }
}

class Params{
  final String name;
  final bool required;

  Params({this.name, this.required});

  factory Params.fromMap(Map<String, dynamic> map) {
    return new Params(
      name: map['name'] as String,
      required: map['required'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'required': this.required,
    } as Map<String, dynamic>;
  }

}

class Codes{
  int code;
  String mess;

  Codes({this.code, this.mess});

  factory Codes.fromMap(Map<String, dynamic> map) {
    return new Codes(
      code: map['code'] as int,
      mess: map['mess'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'code': this.code,
      'mess': this.mess,
    } as Map<String, dynamic>;
  }
}