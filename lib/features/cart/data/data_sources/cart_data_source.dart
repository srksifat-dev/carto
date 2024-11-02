import 'package:carto/features/cart/data/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartDataSource {
  final FirebaseFirestore firebaseFirestore;

  const CartDataSource({
    required this.firebaseFirestore,
  });

  Future<void> addToCart(
      {required String id,
      required String productId,
      required int quantity,
      required double totalPrice,
      required String userId}) async {
    CartModel cartModel = CartModel(
      id: id,
      productId: productId,
      quantity: quantity,
      totalPrice: totalPrice,
    );
    final cartRef = firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(productId);
    final docSnapshot = await cartRef.get();
    if (docSnapshot.exists) {
      await updateQuantity(
          productId: productId,
          updatedQuantity: quantity,
          userId: userId);
    } else {
      await cartRef.set(cartModel.toMap());
    }
  }

  Future<void> updateQuantity({
    required String productId,
    required int updatedQuantity,
    required String userId,
  }) async {
    final cartRef = firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId);

    final docSnapshot = await cartRef.get();

    if (docSnapshot.exists) {
      await cartRef.update({'quantity': updatedQuantity});
    } else {
      throw Exception('Product not found in cart');
    }
  }

  Stream<List<CartModel>> getCartItems({required String userId}) {
    return firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => CartModel.fromMap(doc.data())).toList();
    });
  }

  Future<CartModel?> getProductById({required String productId,required String userId}) async {
    try {
      final doc = await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(productId)
          .get();

      if (doc.exists) {
        return CartModel.fromMap(doc.data()!); // Return product as CartModel
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Can't find the product");
    }
    return null; // Return null if product not found
  }
}
