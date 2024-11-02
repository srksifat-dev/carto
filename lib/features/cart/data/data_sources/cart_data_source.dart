import 'package:carto/features/cart/data/models/cart_model.dart';
import 'package:carto/features/shop/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/bloc/global_bloc_providers.dart';

class CartDataSource {
  final FirebaseFirestore firebaseFirestore;

  const CartDataSource({
    required this.firebaseFirestore,
  });

  Future<void> addToCart(
      {required String id,
      required ProductModel product,
      required int quantity,
      required String userId}) async {
    CartModel cartModel = CartModel(
      id: id,
      product: product,
      quantity: quantity,
    );
    final cartRef = firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(product.id.toString());
      await cartRef.set(cartModel.toMap());

  }

  Future<void> updateQuantity({
    required String productId,
    required bool isIncrement,
    required String userId,
  }) async {
    final cartRef = firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId);

    final docSnapshot = await cartRef.get();

    if (docSnapshot.exists) {
      final quantity = docSnapshot.get(FieldPath(const ["quantity"])) as int;
      await cartRef.update({'quantity': isIncrement ? quantity + 1 : quantity > 1 ? quantity - 1 : quantity});
    } else {
      throw Exception('Product not found in cart');
    }
  }

  Future<List<CartModel>> getCartItems({required String userId}) async {
    try {
      final snapshot = await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();
      final List<CartModel> allCarts =
          snapshot.docs.map((doc) => CartModel.fromMap(doc.data())).toList();
      return allCarts;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<CartModel?> getProductById(
      {required String productId, required String userId}) async {
    try {
      final doc = await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(productId)
          .get();

      if (doc.exists) {
        return CartModel.fromMap(doc.data()!);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Can't find the product");
    }
    return null;
  }

  Future<void> deleteCartItem(String productId) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(productId)
          .delete();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
