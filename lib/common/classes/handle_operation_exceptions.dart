import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';

class AppErrorTypeBuilder {
  final AppErrorType appErrorType;

  AppErrorTypeBuilder({required this.appErrorType});

  ///  Build from [OperationException]
  factory AppErrorTypeBuilder.formOperationException(
    OperationException operationException,
  ) {
    //==> init AppErrorType
    AppErrorType appErrorType = AppErrorType.network;

    //==> loop in graphqlErrors
    for (var element in operationException.graphqlErrors) {
      //start for loop

      /*
      *
      *
      * password is missing
      *
      *
      * */
      if (element.message.contains("password") &&
          element.message.contains("This field is required")) {
        appErrorType = AppErrorType.passwordIsMissing;
        break;
      }

      /*
      *
      *
      *  email already exists
      *
      *
      * */
      if (element.message.contains("Email already exists")) {
        appErrorType = AppErrorType.emailAlreadyExists;
        break;
      }

      /*
      *
      *
      * must be unique
      *
      *
      * */
      if (element.message
          .contains("The fields user, project must make a unique set.")) {
        appErrorType = AppErrorType.mustBeUnique;
        break;
      }

      // end of for loop
    }

    //==> return AppErrorTypeBuilder
    return AppErrorTypeBuilder(appErrorType: appErrorType);
  }

  /// Build from Auth errors
  /*
  * Errors messages and codes mapped to fields or non fields errors. Example:
  * {
  * field_name: [
  *       { "message": "error message",
  *         "code": "error_code"
  *       }
  *             ],
  *  other_field: [ { "message": "error message", "code": "error_code" } ],
  *  nonFieldErrors: [ { "message": "error message", "code": "error_code" } ]
  * }
  * */
  factory AppErrorTypeBuilder.fromAuthErrors(Map<String, dynamic> errors) {
    //==> init AppErrorType
    AppErrorType appErrorType = AppErrorType.unHandledError;

    final nonFieldErrors = errors.containsKey("nonFieldErrors");

    if (nonFieldErrors) {
      final listOfNonFieldErrors = errors["nonFieldErrors"] as List;
      for (var element in listOfNonFieldErrors) {
        final code = (element as Map<String, dynamic>)["code"];
        if (code == "invalid_credentials") {
          appErrorType = AppErrorType.wrongEmailOrPassword;
        }
      }
    }

    return AppErrorTypeBuilder(appErrorType: appErrorType);
  }
}
