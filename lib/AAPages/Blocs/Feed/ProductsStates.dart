part of 'ProductsBloc.dart';

abstract class ProductsState {
  const ProductsState();
}

class ProductsComplete extends ProductsState {
  final List<BlocSize> listProducts;
  const ProductsComplete({this.listProducts});
}


class ProductsFromCategory extends ProductsState {
  final Category category;
  final List<BlocSize> listProducts;
  const ProductsFromCategory({
    @required this.listProducts,
    @required this.category});
}
class ProductsFromSearch extends ProductsState {
  final List<BlocSize> listProducts;
  final String input;
  const ProductsFromSearch({this.listProducts, this.input});
}

class ProductsLoading extends ProductsState{}