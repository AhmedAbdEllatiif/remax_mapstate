import 'package:remax_mapstate/common/enums/user_register_group.dart';

///****************** The different type users ***************** \\\

/// tour ==> when user takes a tour
/// client ==> when user is a normal client
/// broker ==> when user is a broker
/// other ==> the other user
/// noUser ==> No user selected need to login or signup
enum UserType {
  tour,
  client,
  broker,
  ambassador,
  unDefined,
}

UserType userTypeFromUserRegisterGroup(UserRegisterGroup userRegisterGroup) {
  switch (userRegisterGroup) {
    case UserRegisterGroup.buyer:
      return UserType.client;
    case UserRegisterGroup.broker:
      return UserType.broker;
    case UserRegisterGroup.ambassador:
      return UserType.ambassador;
    default:
      return UserType.unDefined;
  }
}

UserType userTypeFromString(String userTypeInString) {
  switch (userTypeInString) {
    case "client":
      return UserType.client;
    case "broker":
      return UserType.broker;
    case "tour":
      return UserType.tour;
    case "ambassador":
      return UserType.ambassador;
    default:
      return UserType.unDefined;
  }
}

/// Extension to convert UserType to string
extension ToString on UserType {
  String toShortString() {
    return toString().split('.').last;
  }
}
