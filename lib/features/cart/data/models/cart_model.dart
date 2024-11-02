import 'package:carto/features/shop/data/models/product_model.dart';

class CartModel{
  final String id;
  final ProductModel product;
  int quantity;

   CartModel({
    required this.id,
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as String,
      product: ProductModel.fromMap(map["product"]),
      quantity: map['quantity'] as int,
    );
  }

  CartModel copyWith({
    String? id,
    ProductModel? product,
    int? quantity,
  }) {
    return CartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}