import 'package:carto/features/cart/data/models/cart_model.dart';

abstract class CartState{
}

class CartInitial extends CartState{
  CartInitial();
}

class CartLoading extends CartState{
  CartLoading();
}

class CartAdded extends CartState{
  CartAdded();
}

class CartUpdated extends CartState{
  CartUpdated();
}

class FindCart extends CartState{
  final CartModel cart;

  FindCart(this.cart);
}

class CartLoaded extends CartState{
  final List<CartModel> carts;
  final double totalAmount;
  CartLoaded({required this.carts,required this.totalAmount,});
}

class CartError extends CartState{
  final String error;
  CartError({required this.error});
}

