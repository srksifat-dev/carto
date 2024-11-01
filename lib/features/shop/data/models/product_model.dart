import 'package:carto/features/shop/data/models/rating_model.dart';

import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  num? id;
  String? title;
  num? price;
  String? description;
  String? category;
  String? image;
  RatingModel? rating;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  ProductModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
        json['rating'] != null ? RatingModel.fromMap(json['rating']) : null;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "category": category,
      "image": image,
      "rating": rating != null ?  rating!.toMap() : "",
    };
  }
}
