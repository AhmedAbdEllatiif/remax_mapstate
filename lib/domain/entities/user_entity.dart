import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';

import 'area_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  UserType userType;
  final List<AreaEntity> favoriteAreas;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    this.favoriteAreas = const [],
  });

  factory UserEntity.empty() => UserEntity(
        id: "-1",
        firstName: AppUtils.undefined,
        lastName: AppUtils.undefined,
        email: AppUtils.undefined,
        phoneNumber: AppUtils.undefined,
        userType: UserType.unDefined,
        favoriteAreas: [],
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
