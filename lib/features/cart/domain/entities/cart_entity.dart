class CartEntity{
  final String id;
  final String productId;
  final int quantity;
  final double totalPrice;

  const CartEntity({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
  });
}