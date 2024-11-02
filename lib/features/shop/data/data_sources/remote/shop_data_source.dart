import 'dart:convert';

import 'package:carto/core/constants/strings.dart';
import 'package:carto/features/shop/data/models/product_model.dart';

import 'package:http/http.dart' as http;

class ShopDataSource {
  Future<List<ProductModel>?> getProducts() async {
    final response = await http.get(Uri.parse("$shopApiBaseUrl$products"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => ProductModel.fromMap(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
  Future<ProductModel?> getProductById({required String productId}) async {
    final response = await http.get(Uri.parse("$shopApiBaseUrl$products/$productId"));
    if (response.statusCode == 200) {
      final Map<String,dynamic> jsonData = json.decode(response.body);
      return ProductModel.fromMap(jsonData);
    } else {
      throw Exception("Failed to load products");
    }
  }
}
