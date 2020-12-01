part of 'UslugiCubit.dart';

abstract class UslugiState {
  const UslugiState();
}

class UslugiComplete extends UslugiState {
  final List<BlocSize> uslugiList;
  const UslugiComplete({this.uslugiList});
}

class UslugiLoading extends UslugiState{}