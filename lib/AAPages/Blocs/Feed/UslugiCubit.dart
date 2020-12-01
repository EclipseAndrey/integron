import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_qick/Providers/ProductProvider/ProductProvider.dart';
import 'package:omega_qick/Utils/DB/Products/BlocSize.dart';


part 'UslugiStates.dart';

class UslugiCubit extends Cubit<UslugiState> {
  UslugiCubit() : super(UslugiLoading()){load();}

  load()async{
    print("Loading uslugi");
    List<BlocSize> uslugi = await ProductProvider.getItems(type: 1);
    emit(UslugiComplete(uslugiList: uslugi));
  }
}