part of 'CartCubit.dart';




abstract class CartState {
  const CartState();
}

class CartComplete extends CartState {
  final List<Product> cartList;
  final List<List<Product>> sortListTovars;
  final List<List<Product>> sortListUslugi;
  final double summT;
  final double summU;
  const CartComplete({this.cartList, this.sortListTovars,this.sortListUslugi, this.summT, this.summU});
}

class CartLoading extends CartState{}