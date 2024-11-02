import 'package:carto/features/shop/data/models/product_model.dart';

abstract class ShopState{
  final List<ProductModel>? products;
  final ProductModel? product;
  final String? error;

  const ShopState({
    this.products,
    this.error, this.product,
  });
}
class ShopInitial extends ShopState{
  ShopInitial();
}

class ShopLoading extends ShopState{
  ShopLoading();
}

class ShopFulfillDone extends ShopState{
  ShopFulfillDone(List<ProductModel> products) : super(products: products);
}

class FindSingleProductById extends ShopState{
  FindSingleProductById(ProductModel product) : super(product: product);
}

class ShopError extends ShopState{
  ShopError(String error) : super(error: error);
}