import 'package:carto/features/cart/data/models/cart_model.dart';

abstract class CartRepository {
  Future<void> addToCart({
    required CartModel cartItem,
    required String userId,
  });

  Future<void> updatedQuantity({
    required String productId,
    required bool isIncrement,
    required String userId,
  });
  Future<CartModel?> getProductById({
    required String productId,
    required String userId,
  });

  Future<List<CartModel>> getAllCarts({
    required String userId,
  });

  Future<void> deleteCart({required String productId});
}
