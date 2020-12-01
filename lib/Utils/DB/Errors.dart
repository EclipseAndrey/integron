import 'Put.dart';

abstract class Errors {

  Put put = Put(localError: true, mess: "ok", error: 200);
  Errors({this.put});
}

abstract class EditPropertyFlags{

  bool editingName = true;
  bool editingValue = true;
  bool canDelete = true;
  EditPropertyFlags({this.editingValue, this.editingName, this.canDelete});
}