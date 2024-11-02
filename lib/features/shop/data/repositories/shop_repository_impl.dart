import 'dart:io' show HttpStatus;

import 'package:carto/features/shop/data/data_sources/remote/shop_data_source.dart';
import 'package:carto/features/shop/data/models/product_model.dart';
import 'package:carto/features/shop/domain/repositories/shop_repository.dart';
import 'package:dio/dio.dart';

import '../../../../core/base/resources/data_state.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopDataSource shopDataSource;

  ShopRepositoryImpl({required this.shopDataSource});

  @override
  Future<DataState<List<ProductModel>>> getProducts() async {
    try {
      final httpResponse = await shopDataSource.getProducts();
      print(httpResponse);
      return DataSuccess(httpResponse!);
    } catch (error) {
      print(error);
      return DataFailed(error.toString());
    }
  }
  @override
  Future<DataState<ProductModel>> getProductById({required String productId}) async {
    try {
      final httpResponse = await shopDataSource.getProductById(productId: productId);
      print(httpResponse);
      return DataSuccess(httpResponse!);
    } catch (error) {
      print(error);
      return DataFailed(error.toString());
    }
  }
}
