import 'package:equatable/equatable.dart';

class BrokerReviewEntity extends Equatable {
  final int rating;
  final String review;

  const BrokerReviewEntity({
    required this.rating,
    required this.review,
  });

  @override
  List<Object?> get props => [];
}
