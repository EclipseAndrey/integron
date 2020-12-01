import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_qick/Providers/ProductProvider/ProductProvider.dart';
import 'package:omega_qick/Utils/DB/Products/BlocSize.dart';

part 'TovarsStates.dart';

class TovarsCubit extends Cubit<TovarsState> {
  TovarsCubit() : super(TovarsLoading()){load();}

  load()async{
    List<BlocSize> tovars = await ProductProvider.getItems(type: 0);
    emit(TovarsComplete(tovarsList: tovars));
  }
}