import 'package:carto/features/cart/data/data_sources/cart_data_source.dart';
import 'package:carto/features/cart/data/models/cart_model.dart';
import 'package:carto/features/cart/domain/entities/cart_entity.dart';
import 'package:carto/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource cartDataSource;

  CartRepositoryImpl({required this.cartDataSource});

  @override
  Future<void> addToCart(
      {required CartEntity cartItem, required String userId}) async {
    cartDataSource.addToCart(
      id: cartItem.id,
      productId: cartItem.productId,
      quantity: cartItem.quantity,
      totalPrice: cartItem.totalPrice,
      userId: userId,
    );
  }

  @override
  Future<void> updatedQuantity(
      {required String productId,
      required int updatedQuantity,
      required String userId}) async {
    cartDataSource.updateQuantity(
      productId: productId,
      updatedQuantity: updatedQuantity,
      userId: userId,
    );
  }

  @override
  Stream<List<CartEntity>> getAllCarts({required String userId}) {
    return cartDataSource.getCartItems(userId: userId);
  }

  @override
  Future<CartEntity?> getProductById({required String productId,required String userId,}) {
    return cartDataSource.getProductById(productId: productId, userId: userId);
  }


}
