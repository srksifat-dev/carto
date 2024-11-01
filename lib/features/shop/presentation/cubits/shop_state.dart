import 'package:carto/features/shop/domain/entities/product_entity.dart';

abstract class ShopState{
  final List<ProductEntity>? products;
  final String? error;

  const ShopState({
    this.products,
    this.error,
  });
}
class ShopInitial extends ShopState{
  ShopInitial();
}

class ShopLoading extends ShopState{
  ShopLoading();
}

class ShopFulfillDone extends ShopState{
  ShopFulfillDone(List<ProductEntity> products) : super(products: products);
}

class ShopError extends ShopState{
  ShopError(String error) : super(error: error);
}