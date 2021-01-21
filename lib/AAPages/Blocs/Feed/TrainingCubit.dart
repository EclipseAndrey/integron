
part of 'ProductsBloc.dart';

class TrainingCubit extends Cubit<ProductsState> {
  TrainingCubit() : super(ProductsLoading()){load();}

  load()async{
    List<BlocSize> trainings = await ProductProvider.getItems(type: 2);
    emit(ProductsComplete(listProducts: trainings));
  }

  search(String input)async {
    List<BlocSize> trainings = await SearchProvider.search(input, type: 2);
    if(trainings == null){
      emit(ProductsLoading());
      load();
    }else{
      emit(ProductsFromSearch(listProducts: trainings, input: input));
    }
  }

  selectCategory(Category category)async{
    List<BlocSize> trainings = await CategoryProvider.getItemsCategory(category.route, type: 2 );
    if(trainings == null){
      emit(ProductsLoading());
      load();
    }else {
      emit(ProductsFromCategory(listProducts: trainings, category: category));
    }
  }

  closeWindow(){
    emit(ProductsLoading());
    load();
  }






}