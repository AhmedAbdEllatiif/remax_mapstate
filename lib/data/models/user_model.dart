import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/data/models/broker_review_model.dart';
import 'package:remax_mapstate/domain/entities/users/user_entity.dart';

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
List<UserModel> listUserModelFormBroker(dynamic json) {
  final List<UserModel> brokers = [];

  if (json == null) return brokers;

  if (json["brokers"] == null) return brokers;

  // if (json["brokers"]["user"] == null) return brokers;

  //final json = jsonDecode(body);
  return List<UserModel>.from(json["brokers"].map(
    (element) => UserModel.formJsonBroker(
      userJson: element["user"],
      mapEstateUserJson: element["user"]["mapEstateUser"],
      rating: element["brokerRating"],
      doneDeals: element["doneDeals"],
      yearsOfExperience: element["yearsOfExperience"],
      favoriteAreas: element["favoriteRegions"],
      brokerReviews: element["reviews"],
    ),
  ));
}

/// parse to user model
List<UserModel> listUserModelFormAmbassador(dynamic json) {
  final List<UserModel> ambassadors = [];

  if (json == null) return ambassadors;

  if (json["ambassadors"] == null) return ambassadors;

  // if (json["brokers"]["user"] == null) return brokers;

  //final json = jsonDecode(body);
  return List<UserModel>.from(json["ambassadors"].map(
    (element) => UserModel.formJsonAmbassador(
      userJson: element["user"],
      mapEstateUserJson: element["user"]["mapEstateUser"],
      dateOfBirth: element["dateOfBirth"],
      ambassadorJobTitle: element["currentJobTitle"],
      ambassadorDoneDealsCount: element["doneDealsCount"],
    ),
  ));
}

/// parse to user model
/*
* users{
  users(pk: 62){
    user{
      id
      firstName
      email
      phone
      groups{
        id
        name
      }
    }
  }
}*/
List<UserModel> listUserModelFormUsers(dynamic json) {
  final List<UserModel> users = [];

  if (json == null) return users;

  if (json["users"] == null) return users;

  // if (json["brokers"]["user"] == null) return brokers;

  //final json = jsonDecode(body);
  return List<UserModel>.from(json["users"].map(
    (element) => UserModel.formJsonBuyer(
      userJson: element["user"],
      mapEstateUserJson: element["user"]["mapEstateUser"],
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
  final String userAvatar;
  final double userBrokerRating;
  final int userDoneDeals;
  final int yearsOfExperience;
  final List<AreaModel> userFavoriteAreas;

  final DateTime? dateOfBirth;
  final String ambassadorJobTitle;
  final int ambassadorDoneDealsCount;
  final List<BrokerReviewModel> brokerReviews;

  UserModel({
    required this.userId,
    required this.userPk,
    required this.userFirstName,
    required this.userLastName,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.userAvatar,

    //only for brokers
    required this.userFavoriteAreas,
    required this.yearsOfExperience,
    required this.userBrokerRating,
    required this.userDoneDeals,
    required this.brokerReviews,

    // only for ambassadors
    required this.dateOfBirth,
    required this.ambassadorJobTitle,
    required this.ambassadorDoneDealsCount,
  }) : super(
          id: userPk == -1 ? userId : userPk.toString(),
          firstName: userFirstName,
          lastName: userLastName,
          email: userEmail,
          experienceYears: yearsOfExperience,
          phoneNumber: userPhoneNumber,
          userType: UserType.unDefined,
          favoriteAreas: userFavoriteAreas,
          brokerDoneDeals: userDoneDeals,
          brokerRating: userBrokerRating,
          userProfileImage: userAvatar,
          reviews: brokerReviews,
        );

  factory UserModel.formJson(dynamic json) {
    return UserModel(
      userId: json["id"] ?? "-1",
      userPk: json["pk"] ?? -1,
      userFirstName: json["firstName"] ?? AppUtils.undefined,
      userLastName: json["lastName"] ?? AppUtils.undefined,
      userEmail: json["email"] ?? AppUtils.undefined,
      userPhoneNumber: json["phone"] ?? AppUtils.undefined,
      yearsOfExperience: -1,
      userFavoriteAreas: const [],
      // from mapStateUser
      userAvatar: json["mapEstateUser"] != null
          ? json["mapEstateUser"]["avatar"] ?? AppUtils.undefined
          : AppUtils.undefined,

      // broker rating
      userBrokerRating: 0,
      brokerReviews: const [],

      // done deals
      userDoneDeals: 0,

      dateOfBirth: DateTime.now(),
      ambassadorJobTitle: AppUtils.undefined,
      ambassadorDoneDealsCount: 0,
    );
  }

  /*
  *
  *
  * broker
  *
  *
  * */
  factory UserModel.formJsonBroker({
    required dynamic userJson,
    required dynamic yearsOfExperience,
    required dynamic favoriteAreas,
    required dynamic rating,
    required dynamic doneDeals,
    required dynamic mapEstateUserJson,
    required dynamic brokerReviews,
  }) {
    return UserModel(
      // from userJson
      userId: userJson["id"] ?? "-1",
      userPk: userJson["pk"] ?? -1,
      userFirstName: userJson["firstName"] ?? AppUtils.undefined,
      userLastName: userJson["lastName"] ?? AppUtils.undefined,
      userEmail: userJson["email"] ?? AppUtils.undefined,
      userPhoneNumber: userJson["phone"] ?? AppUtils.undefined,

      // from mapStateUser
      userAvatar: mapEstateUserJson["avatar"] ?? AppUtils.undefined,

      // broker rating
      userBrokerRating: rating != null ? double.tryParse(rating) ?? 0 : 0.0,

      // done deals
      userDoneDeals: doneDeals ?? 0,

      yearsOfExperience: yearsOfExperience ?? 0,
      userFavoriteAreas: favoriteAreas != null
          ? listOfAreasFromFavRegionsJson(favoriteAreas)
          : [],

      brokerReviews:
          brokerReviews != null ? listOfBrokerReviews(brokerReviews) : [],

      dateOfBirth: DateTime.now(),
      ambassadorJobTitle: AppUtils.undefined,
      ambassadorDoneDealsCount: 0,
    );
  }

  /*
  *
  *
  * Buyer
  *
  *
  * */
  factory UserModel.formJsonBuyer({
    required dynamic userJson,
    required dynamic mapEstateUserJson,
  }) {
    return UserModel(
      // from userJson
      userId: userJson["id"] ?? "-1",
      userPk: userJson["pk"] ?? -1,
      userFirstName: userJson["firstName"] ?? AppUtils.undefined,
      userLastName: userJson["lastName"] ?? AppUtils.undefined,
      userEmail: userJson["email"] ?? AppUtils.undefined,
      userPhoneNumber: userJson["phone"] ?? AppUtils.undefined,

      // from mapStateUser
      userAvatar: mapEstateUserJson["avatar"] ?? AppUtils.undefined,

      // broker rating
      userBrokerRating: 0.0,

      // done deals
      userDoneDeals: 0,

      yearsOfExperience: 0,
      userFavoriteAreas: const [],
      brokerReviews: const [],

      dateOfBirth: DateTime.now(),
      ambassadorJobTitle: AppUtils.undefined,
      ambassadorDoneDealsCount: 0,
    );
  }

  /*
  *
  *
  * ambassador
  *
  *
  * */
  factory UserModel.formJsonAmbassador({
    required dynamic userJson,
    required dynamic mapEstateUserJson,
    required dynamic dateOfBirth,
    required dynamic ambassadorJobTitle,
    required dynamic ambassadorDoneDealsCount,
  }) {
    return UserModel(
      // from userJson
      userId: userJson["id"] ?? "-1",
      userPk: userJson["pk"] ?? -1,
      userFirstName: userJson["firstName"] ?? AppUtils.undefined,
      userLastName: userJson["lastName"] ?? AppUtils.undefined,
      userEmail: userJson["email"] ?? AppUtils.undefined,
      userPhoneNumber: userJson["phone"] ?? AppUtils.undefined,

      // from mapStateUser
      userAvatar: mapEstateUserJson["avatar"] ?? AppUtils.undefined,

      // broker rating
      userBrokerRating: 0.0,

      // done deals
      userDoneDeals: 0,

      yearsOfExperience: 0,
      userFavoriteAreas: const [],
      brokerReviews: const [],

      dateOfBirth: dateOfBirth,
      ambassadorJobTitle: ambassadorJobTitle ?? AppUtils.undefined,
      ambassadorDoneDealsCount: ambassadorDoneDealsCount ?? 0,
    );
  }

  /*
  *
  *
  * empty
  *
  * */
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
      // from mapStateUser
      userAvatar: AppUtils.undefined,

      // broker rating
      userBrokerRating: 0,
      brokerReviews: const [],

      // done deals
      userDoneDeals: 0,

      dateOfBirth: DateTime.now(),
      ambassadorJobTitle: AppUtils.undefined,
      ambassadorDoneDealsCount: 0,
    );
  }
}
