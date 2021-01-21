part of 'ProductsBloc.dart';

class UslugiCubit extends Cubit<ProductsState> {
  UslugiCubit() : super(ProductsLoading()){load();}

  load()async{
    print("Loading uslugi");
    List<BlocSize> uslugi = await ProductProvider.getItems(type: 1);
    emit(ProductsComplete(listProducts: uslugi));
  }

  search(String input)async{
    List<BlocSize> uslugi = await SearchProvider.search(input, type:1);
    if(uslugi == null){
      emit(ProductsLoading());
      load();
    }else{
      emit(ProductsFromSearch(listProducts: uslugi, input: input));
    }
  }

  selectCategory(Category category)async{
    List<BlocSize> uslugi = await CategoryProvider.getItemsCategory(category.route, type: 1);
    if(uslugi == null){
      emit(ProductsLoading());
      load();
    }else{
      emit(ProductsFromCategory(listProducts: uslugi, category: category));
    }
  }

  closeWindow(){
    emit(ProductsLoading());
    load();
  }
}