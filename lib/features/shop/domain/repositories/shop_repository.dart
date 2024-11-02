import 'package:carto/core/base/resources/data_state.dart';
import 'package:carto/features/shop/data/models/product_model.dart';

abstract class ShopRepository{
  Future<DataState<List<ProductModel>>> getProducts();
  Future<DataState<ProductModel>> getProductById({required String productId});
}