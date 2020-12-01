part of 'CategoryCubit.dart';



abstract class CategoryState {
  const CategoryState();
}

class CategoryComplete extends CategoryState {
  final List<Category> categoryList;
  const CategoryComplete({this.categoryList});
}

class CategoryLoading extends CategoryState{}