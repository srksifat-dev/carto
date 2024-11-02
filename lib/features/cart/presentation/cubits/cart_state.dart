import 'package:carto/features/cart/domain/entities/cart_entity.dart';

abstract class CartState{
  final Stream<List<CartEntity>>? carts;
  final String? error;

  CartState({ this.carts,  this.error,});
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

class FindProduct extends CartState{
  final CartEntity cart;

  FindProduct(this.cart);
}

class CartLoadedDone extends CartState{
  CartLoadedDone(Stream<List<CartEntity>> carts) : super(carts: carts);
}

class CartError extends CartState{
  CartError(String error) : super(error: error);
}

