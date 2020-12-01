import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omega_qick/Providers/CategoryProvider/CategoryProvider.dart';
import 'package:omega_qick/Utils/DB/Category/Category.dart';
part 'CategoryStates.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryLoading()){load();}

  load()async{
    List<Category> category = await CategoryProvider.getCategories();
    emit(CategoryComplete(categoryList: category));
  }

}