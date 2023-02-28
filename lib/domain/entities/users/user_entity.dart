import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/constants/api_constants.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/domain/entities/BrokerReviewEntity.dart';

import '../area_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String userProfileImage;
  UserType userType;
  final int experienceYears;
  final List<AreaEntity> favoriteAreas;
  final List<BrokerReviewEntity> reviews;

  final double brokerRating;
  final num brokerDoneDeals;
  late final String avatar;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.experienceYears,
    required this.userProfileImage,
    required this.brokerRating,
    required this.brokerDoneDeals,
    required this.reviews,
    this.favoriteAreas = const [],
  }) {
    if (userProfileImage != AppUtils.undefined) {
      avatar = ApiConstants.baseMediaWithoutUrl + userProfileImage;
    } else {
      avatar = AppUtils.undefined;
    }
  }

  factory UserEntity.empty() => UserEntity(
        id: "-1",
        firstName: AppUtils.undefined,
        lastName: AppUtils.undefined,
        email: AppUtils.undefined,
        phoneNumber: AppUtils.undefined,
        userType: UserType.unDefined,
        experienceYears: 0,
        favoriteAreas: const [],
        brokerDoneDeals: -1,
        brokerRating: -1,
        reviews: const [],
        userProfileImage: AppUtils.undefined,
      );

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return "firstName: $firstName\n"
        "lastName: $lastName\n"
        "email: $email\n"
        "phone: $phoneNumber\n"
        "userType: ${userType.toShortString()}\n";
  }
}
