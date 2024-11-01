import 'package:carto/core/base/resources/data_state.dart';
import 'package:carto/features/shop/domain/entities/product_entity.dart';

abstract class ShopRepository{
  Future<DataState<List<ProductEntity>>> getProducts();
}