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
  other,
  noUser,
}


/// Extension to convert UserType to string
extension ToString on UserType {
  String toShortString() {
    return toString().split('.').last;
  }
}
