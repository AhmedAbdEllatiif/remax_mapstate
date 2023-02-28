import '../../common/constants/app_utils.dart';
import '../../domain/entities/BrokerReviewEntity.dart';

List<BrokerReviewModel> listOfBrokerReviews(dynamic json) {
  final List<BrokerReviewModel> reviews = [];

  if (json == null) return reviews;

  for (var value in (json as List)) {
    reviews.add(BrokerReviewModel.fromJson(value));
  }

  return reviews;
}

class BrokerReviewModel extends BrokerReviewEntity {
  final int brokerRating;
  final String brokerReview;

  const BrokerReviewModel({
    required this.brokerRating,
    required this.brokerReview,
  }) : super(
          rating: brokerRating,
          review: brokerReview,
        );

  factory BrokerReviewModel.fromJson(dynamic json) => BrokerReviewModel(
        brokerRating: json["brokerRating"] ?? -1,
        brokerReview: json["brokerReview"] ?? "",
      );
}
