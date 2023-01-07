enum UserRegisterGroup {
  buyer,
  broker,
  ambassador,
}

extension ToInt on UserRegisterGroup {
  int convertToInt() {
    switch (this) {
      case UserRegisterGroup.buyer:
        return -1;
      case UserRegisterGroup.broker:
        return 3;
      case UserRegisterGroup.ambassador:
        return 4;
    }
  }
}
