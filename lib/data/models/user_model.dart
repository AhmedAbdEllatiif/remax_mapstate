import 'dart:convert';

import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';

import '../../common/enums/user_types.dart';

/// parse to user model
UserModel userModelFormJson(Map<String,dynamic> json) {
  //final json = jsonDecode(body);

  return UserModel.formJson(json["user"]);
}

class UserModel extends UserEntity {
  final int userId;
  final String userFirstName;
  final String userLastName;
  final String userEmail;
  final int yearsOfExperience;

  const UserModel({
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.yearsOfExperience,
  }) : super(
            id: userId,
            firstName: userFirstName,
            lastName: userLastName,
            email: userEmail,
            userType: UserType.unDefined);

  factory UserModel.formJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["id"] ?? -1,
      userFirstName: json["firstName"] ?? AppUtils.undefined,
      userLastName: json["lastName"] ?? AppUtils.undefined,
      userEmail: json["email"] ?? AppUtils.undefined,
      yearsOfExperience: json["yearsOfExperience"] ?? 0,
    );
  }
}
