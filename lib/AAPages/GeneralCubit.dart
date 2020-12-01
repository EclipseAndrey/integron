import 'package:flutter_bloc/flutter_bloc.dart';
part 'StatesGeneral.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(GeneralCurrentPage(0));

  void selectPage(int index){
    emit(GeneralCurrentPage(index));
  }

}