import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integron/Providers/CategoryProvider/CategoryProvider.dart';
import 'package:integron/Providers/ProductProvider/ProductProvider.dart';
import 'package:integron/Providers/SearchProvider/SearchProvider.dart';
import 'package:integron/Utils/DB/Category/Category.dart';
import 'package:integron/Utils/DB/Products/BlocSize.dart';


part 'UslugiStates.dart';

class UslugiCubit extends Cubit<UslugiState> {
  UslugiCubit() : super(UslugiLoading()){load();}

  load()async{
    print("Loading uslugi");
    List<BlocSize> uslugi = await ProductProvider.getItems(type: 1);
    emit(UslugiComplete(uslugiList: uslugi));
  }

  search(String input)async{
    List<BlocSize> uslugi = await SearchProvider.search(input, type:1);
    if(uslugi == null){
      emit(UslugiLoading());
      load();
    }else{
      emit(UslugiSearch(uslugiList: uslugi, input: input));
    }
  }

  selectCategory(Category category)async{
    List<BlocSize> uslugi = await CategoryProvider.getItemsCategory(category.route, type: 1);
    if(uslugi == null){
      emit(UslugiLoading());
      load();
    }else{
      emit(UslugiCatigory(uslugiList: uslugi, category: category));
    }
  }

  closeWindow(){
    emit(UslugiLoading());
    load();
  }

}