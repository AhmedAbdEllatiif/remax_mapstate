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


/// to convert userType into group id to update server
extension ToInt on UserType {
  int convertToGroupId() {
    switch (this) {
      case UserType.client:
        return -1;
      case UserType.broker:
        return 3;
      case UserType.ambassador:
        return 4;
      case UserType.unDefined:
        return -10;
      case UserType.tour:
        return 0;
    }
  }
}
