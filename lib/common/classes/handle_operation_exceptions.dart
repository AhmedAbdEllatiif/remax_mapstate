import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';

class AppErrorTypeBuilder {
  final AppErrorType appErrorType;

  AppErrorTypeBuilder({required this.appErrorType});

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

      // end of for loop
    }

    //==> return AppErrorTypeBuilder
    return AppErrorTypeBuilder(appErrorType: appErrorType);
  }
}
