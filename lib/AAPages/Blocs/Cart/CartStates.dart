part of 'CartCubit.dart';




abstract class CartState {
  const CartState();
}

class CartComplete extends CartState {
  final List<Product> cartList;
  final List<List<Product>> sortListTovars;
  final List<List<Product>> sortListUslugi;
  final List<List<Product>> sortListTrainings;
  final double summT;
  final double summU;
  final double summR;
  const CartComplete({this.cartList, this.sortListTovars,this.sortListUslugi, this.summT, this.summU, this.sortListTrainings,this.summR});
}

class CartLoading extends CartState{}