import 'package:carto/features/cart/data/data_sources/cart_data_source.dart';
import 'package:carto/features/cart/data/models/cart_model.dart';
import 'package:carto/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource cartDataSource;

  CartRepositoryImpl({required this.cartDataSource});

  @override
  Future<void> addToCart(
      {required CartModel cartItem, required String userId}) async {
    cartDataSource.addToCart(
      id: cartItem.id,
      product: cartItem.product,
      quantity: cartItem.quantity,
      userId: userId,
    );
  }

  @override
  Future<void> updatedQuantity(
      {required String productId,
      required bool isIncrement,
      required String userId}) async {
    cartDataSource.updateQuantity(
      productId: productId,isIncrement: isIncrement,
      userId: userId,
    );
  }

  @override
  Future<List<CartModel>> getAllCarts({required String userId}) {
    return cartDataSource.getCartItems(userId: userId);
  }

  @override
  Future<CartModel?> getProductById({required String productId,required String userId,}) {
    return cartDataSource.getProductById(productId: productId, userId: userId);
  }

  @override
  Future<void> deleteCart({required String productId}) async {
    cartDataSource.deleteCartItem(productId);
  }


}
