import 'package:carto/features/cart/domain/entities/cart_entity.dart';

class CartModel extends CartEntity{
  final String id;
  final String productId;
  final int quantity;
  final double totalPrice;

  const CartModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
  }):super(
    id: id,
    productId: productId,
    quantity: quantity,
    totalPrice: totalPrice,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as String,
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
      totalPrice: map['totalPrice'] as double,
    );
  }


}