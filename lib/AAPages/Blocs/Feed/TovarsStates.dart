part of 'TovarsCubit.dart';

abstract class TovarsState {
  const TovarsState();
}

class TovarsComplete extends TovarsState {
  final List<BlocSize> tovarsList;
  const TovarsComplete({this.tovarsList});
}

class TovarsLoading extends TovarsState{}