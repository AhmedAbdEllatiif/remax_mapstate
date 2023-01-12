
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';

import '../../common/enums/user_types.dart';
import 'area_model.dart';

/// parse to user model from 'me' json
UserModel userModelFormMe(Map<String, dynamic> json) {
  return UserModel.formJson(json["me"] ?? {});
}

/// parse to user model from 'user' json
UserModel userModelFormUser(Map<String, dynamic> json) {
  return UserModel.formJson(json["user"] ?? {});
}

/// parse to user model 'updateUser' json
UserModel userModelFormUpdateUser(dynamic data) {
  return data == null
      ? UserModel.formJson(const {})
      : data["updateUser"] == null
          ? UserModel.formJson(const {})
          : UserModel.formJson(data["updateUser"]["user"] ?? {});
}

/// parse to user model
List<UserModel> listUserModelFormBroker(Map<String, dynamic> json) {
  //final json = jsonDecode(body);
  return List<UserModel>.from(json["brokers"].map(
    (element) => UserModel.formJsonBroker(
      element["user"],
      element["yearsOfExperience"],
      element["favoriteRegions"],
    ),
  ));
}

class UserModel extends UserEntity {
  final String userId;
  final int userPk;
  final String userFirstName;
  final String userLastName;
  final String userPhoneNumber;
  final String userEmail;
  final int yearsOfExperience;
  final List<AreaModel> userFavoriteAreas;

  UserModel({
    required this.userId,
    required this.userPk,
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.yearsOfExperience,
    required this.userFavoriteAreas,
  }) : super(
          id: userPk == -1 ? userId : userPk.toString(),
          firstName: userFirstName,
          lastName: userLastName,
          email: userEmail,
          experienceYears: yearsOfExperience,
          phoneNumber: userPhoneNumber,
          userType: UserType.unDefined,
          favoriteAreas: userFavoriteAreas,
        );

  factory UserModel.formJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["id"] ?? "-1",
      userPk: json["pk"] ?? -1,
      userFirstName: json["firstName"] ?? AppUtils.undefined,
      userLastName: json["lastName"] ?? AppUtils.undefined,
      userEmail: json["email"] ?? AppUtils.undefined,
      userPhoneNumber: json["phone"] ?? AppUtils.undefined,
      yearsOfExperience: -1,
      userFavoriteAreas: const [],
    );
  }

  factory UserModel.formJsonBroker(Map<String, dynamic> userJson,
      dynamic yearsOfExperience, dynamic favoriteAreas) {
    return UserModel(
      userId: userJson["id"] ?? "-1",
      userPk: userJson["pk"] ?? -1,
      userFirstName: userJson["firstName"] ?? AppUtils.undefined,
      userLastName: userJson["lastName"] ?? AppUtils.undefined,
      userEmail: userJson["email"] ?? AppUtils.undefined,
      userPhoneNumber: userJson["phone"] ?? AppUtils.undefined,
      yearsOfExperience: yearsOfExperience ?? 0,
      userFavoriteAreas: favoriteAreas != null
          ? listOfAreasFromFavRegionsJson(favoriteAreas)
          : [],
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
      userFavoriteAreas: const [],
    );
  }
}
