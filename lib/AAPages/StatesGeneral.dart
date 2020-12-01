part of 'GeneralCubit.dart';

abstract class GeneralState {
  const GeneralState();
}

class GeneralCurrentPage extends GeneralState {
  final int index;
  const GeneralCurrentPage(this.index);
}