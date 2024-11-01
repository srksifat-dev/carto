import 'package:carto/features/shop/domain/entities/rating_entity.dart';

class ProductEntity {
  final num? id;
  final String? title;
  final num? price;
  final String? description;
  final String? category;
  final String? image;
  final RatingEntity? rating;

  ProductEntity({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });
}
