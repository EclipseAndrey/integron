import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_qick/Providers/CategoryProvider/CategoryProvider.dart';
import 'package:omega_qick/Providers/ProductProvider/ProductProvider.dart';
import 'package:omega_qick/Providers/SearchProvider/SearchProvider.dart';
import 'package:omega_qick/Utils/DB/Category/Category.dart';
import 'package:omega_qick/Utils/DB/Products/BlocSize.dart';

part 'TovarsStates.dart';

class TovarsCubit extends Cubit<TovarsState> {
  TovarsCubit() : super(TovarsLoading()){load();}

  load()async{
    List<BlocSize> tovars = await ProductProvider.getItems(type: 0);
    emit(TovarsComplete(tovarsList: tovars));
  }

  search(String input)async {
    List<BlocSize> tovars = await SearchProvider.search(input, type: 0);
    if(tovars == null){
      emit(TovarsLoading());
      load();
    }else{
      emit(TovarsSearch(tovarsList: tovars, input: input));
    }
  }

  selectCategory(Category category)async{
    List<BlocSize> tovars = await CategoryProvider.getItemsCategory(category.route, type: 0);
    if(tovars == null){
      emit(TovarsLoading());
      load();
    }else {
      emit(TovarsCatigory(tovarsList: tovars, category: category));
    }
  }

  closeWindow(){
    emit(TovarsLoading());
    load();
  }






}