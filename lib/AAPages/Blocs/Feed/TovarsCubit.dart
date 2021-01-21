

part of 'ProductsBloc.dart';

class TovarsCubit extends Cubit<ProductsState> {
  TovarsCubit() : super(ProductsLoading()){load();}

  load()async{
    List<BlocSize> tovars = await ProductProvider.getItems(type: 0);
    emit(ProductsComplete(listProducts: tovars));
  }

  search(String input)async {
    List<BlocSize> tovars = await SearchProvider.search(input, type: 0);
    if(tovars == null){
      emit(ProductsLoading());
      load();
    }else{
      emit(ProductsFromSearch(listProducts: tovars, input: input));
    }
  }

  selectCategory(Category category)async{
    List<BlocSize> tovars = await CategoryProvider.getItemsCategory(category.route, type: 0 );
    if(tovars == null){
      emit(ProductsLoading());
      load();
    }else {
      emit(ProductsFromCategory(listProducts: tovars, category: category));
    }
  }

  closeWindow(){
    emit(ProductsLoading());
    load();
  }






}