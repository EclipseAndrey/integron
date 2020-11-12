abstract class Errors {
  bool error = false;
}

abstract class EditPropertyFlags{

  bool editingName = true;
  bool editingValue = true;
  bool canDelete = true;
  EditPropertyFlags({this.editingValue, this.editingName, this.canDelete});
}