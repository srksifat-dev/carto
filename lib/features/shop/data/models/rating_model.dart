
class RatingModel {
  num? rate;
  num? count;
  RatingModel({ this.rate, this.count});

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