import 'package:carto/features/shop/domain/entities/rating_entity.dart';

class RatingModel extends RatingEntity {

  RatingModel({ super.rate, super.count});

  RatingModel.fromMap(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'];
  }

  Map<String, dynamic> toMap() {
    return{
      "rate" : rate,
      "count" : count,
    };
  }
}