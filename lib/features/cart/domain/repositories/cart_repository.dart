import 'package:carto/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<void> addToCart({
    required CartEntity cartItem,
    required String userId,
  });

  Future<void> updatedQuantity({
    required String productId,
    required int updatedQuantity,
    required String userId,
  });
  Future<CartEntity?> getProductById({
    required String productId,
    required String userId,
  });

  Stream<List<CartEntity>> getAllCarts({
    required String userId,
  });
}
