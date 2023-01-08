import 'dart:convert';

import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';

import '../../common/enums/user_types.dart';

/// parse to user model
UserModel userModelFormJson(Map<String, dynamic> json) {
  //final json = jsonDecode(body);

  return UserModel.formJson(json["user"]);
}

/// parse to user model
List<UserModel> listUserModelFormBroker(Map<String, dynamic> json) {
  //final json = jsonDecode(body);
  return List<UserModel>.from(json["brokers"].map((element) =>
      UserModel.formJsonBroker(element["user"], element["yearsOfExperience"])));
}

class UserModel extends UserEntity {
  final String userId;
  final int userPk;
  final String userFirstName;
  final String userLastName;
  final String userPhoneNumber;
  final String userEmail;
  final int yearsOfExperience;

  UserModel({
    required this.userId,
    required this.userPk,
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.yearsOfExperience,
  }) : super(
          id: userPk.toString(),
          firstName: userFirstName,
          lastName: userLastName,
          email: userEmail,
          experienceYears: yearsOfExperience,
          phoneNumber: userPhoneNumber,
          userType: UserType.unDefined,
        );

  factory UserModel.formJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["id"] ?? "-1",
      userPk: json["pk"] ?? -1,
      userFirstName: json["firstName"] ?? AppUtils.undefined,
      userLastName: json["lastName"] ?? AppUtils.undefined,
      userEmail: json["email"] ?? AppUtils.undefined,
      userPhoneNumber: json["phone"] ?? AppUtils.undefined,
      yearsOfExperience: json["yearsOfExperience"] ?? 0,
    );
  }

  factory UserModel.formJsonBroker(
      Map<String, dynamic> userJson, dynamic yearsOfExperience) {
    return UserModel(
      userId: userJson["id"] ?? "-1",
      userPk: userJson["pk"] ?? -1,
      userFirstName: userJson["firstName"] ?? AppUtils.undefined,
      userLastName: userJson["lastName"] ?? AppUtils.undefined,
      userEmail: userJson["email"] ?? AppUtils.undefined,
      userPhoneNumber: userJson["phone"] ?? AppUtils.undefined,
      yearsOfExperience: yearsOfExperience ?? 0,
    );
  }

  factory UserModel.empty() {
    return UserModel(
      userId: "-1",
      userPk: -1,
      userFirstName: AppUtils.undefined,
      userLastName: AppUtils.undefined,
      userEmail: AppUtils.undefined,
      userPhoneNumber: AppUtils.undefined,
      yearsOfExperience: 0,
    );
  }
}
