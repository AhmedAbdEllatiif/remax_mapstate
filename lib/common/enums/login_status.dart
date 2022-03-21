enum LoginStatus{ loggedIn , notLoggedIn}

/// Extension to convert LoginStatus to string
extension ToString on LoginStatus {
  String toShortString() {
    return toString().split('.').last;
  }
}
