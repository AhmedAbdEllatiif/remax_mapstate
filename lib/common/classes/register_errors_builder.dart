import '../../domain/entities/app_error.dart';

class RegisterErrorBuilder {
  final AppErrorType appErrorType;

  RegisterErrorBuilder({required this.appErrorType});

  ///  Build from [OperationException]
  factory RegisterErrorBuilder.fromError(
    dynamic errors,
  ) {
    //==> init AppErrorType
    AppErrorType appErrorType = AppErrorType.unHandledError;

    if (errors["email"] != null) {
      for (var element in errors["email"]) {
        /*
      *
      *
      *  email already exists
      *
      *
      * */
        if (element["message"].contains("Email already exists")) {
          appErrorType = AppErrorType.emailAlreadyExists;
          break;
        }
      }
    }



    //==> return AppErrorTypeBuilder
    return RegisterErrorBuilder(appErrorType: appErrorType);
  }
}
