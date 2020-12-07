part of 'UslugiCubit.dart';

abstract class UslugiState {
  const UslugiState();
}

class UslugiComplete extends UslugiState {
  final List<BlocSize> uslugiList;
  const UslugiComplete({this.uslugiList});
}

class UslugiCatigory extends UslugiState {

  final Category category;
  final List<BlocSize> uslugiList;
  const UslugiCatigory({
  @required this.uslugiList,
  @required this.category});
}

class UslugiSearch extends UslugiState {
  final List<BlocSize> uslugiList;
  final String input;
  const UslugiSearch({this.uslugiList, this.input});
}

class UslugiLoading extends UslugiState{}