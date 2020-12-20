import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/Providers/CategoryProvider/CategoryProvider.dart';
import 'package:integron/Providers/ProductProvider/ProductProvider.dart';
import 'package:integron/Providers/SearchProvider/SearchProvider.dart';
import 'package:integron/Utils/DB/Category/Category.dart';
import 'package:integron/Utils/DB/Products/BlocSize.dart';

part 'TovarsStates.dart';

class TovarsCubit extends Cubit<TovarsState> {
  TovarsCubit() : super(TovarsLoading()){load();}

  load()async{
    List<BlocSize> tovars = await ProductProvider.getItems();
    emit(TovarsComplete(tovarsList: tovars));
  }

  search(String input)async {
    List<BlocSize> tovars = await SearchProvider.search(input,);
    if(tovars == null){
      emit(TovarsLoading());
      load();
    }else{
      emit(TovarsSearch(tovarsList: tovars, input: input));
    }
  }

  selectCategory(Category category)async{
    List<BlocSize> tovars = await CategoryProvider.getItemsCategory(category.route, );
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