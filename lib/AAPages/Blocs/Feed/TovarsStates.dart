part of 'TovarsCubit.dart';

abstract class TovarsState {
  const TovarsState();
}

class TovarsComplete extends TovarsState {
  final List<BlocSize> tovarsList;
  const TovarsComplete({this.tovarsList});
}


class TovarsCatigory extends TovarsState {
  final Category category;
  final List<BlocSize> tovarsList;
  const TovarsCatigory({
    @required this.tovarsList,
    @required this.category});
}
class TovarsSearch extends TovarsState {
  final List<BlocSize> tovarsList;
  final String input;
  const TovarsSearch({this.tovarsList, this.input});
}

class TovarsLoading extends TovarsState{}