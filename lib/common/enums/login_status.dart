enum LoginStatus{ loggedIn , notLoggedIn}

/// Extension to convert UserType to string
extension ToString on LoginStatus {
  String toShortString() {
    return toString().split('.').last;
  }
}
