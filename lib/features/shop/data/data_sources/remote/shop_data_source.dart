import 'dart:convert';

import 'package:carto/core/constants/strings.dart';
import 'package:carto/features/shop/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:http/http.dart' as http;

// part 'shop_data_source.g.dart';
//
// @RestApi(baseUrl: shopApiBaseUrl)
// abstract class ShopDataSource{
//   factory ShopDataSource(Dio dio) = _ShopDataSource;
//
//   @GET("/$products")
//   Future<HttpResponse<List<ProductModel>>> getProducts();
// }

class ShopDataSource {
  Future<List<ProductModel>?> getProducts()async{
    final response = await http.get(Uri.parse("$shopApiBaseUrl$products"));
if (response.statusCode == 200){
  print("Status COde 200");
  final List<dynamic> jsonData = json.decode(response.body);
  print(jsonData);
  return jsonData.map((json) => ProductModel.fromMap(json)).toList();
}else{
  throw Exception("Failed to load products");
}
  }

}