import 'package:equatable/equatable.dart';

enum AppErrorType {
  api,
  network,
  localDB,
  unAuthorized,
  sharedPreferences,
  validation,
  canNotOpenFacebook,
  canNotMakePhoneCall,
  canOpenWhatsapp,
  errorWhileOpenMap,

  pickImage,
  unHandledError,
  emailAlreadyExists,
  passwordIsMissing,
  wrongEmailOrPassword,


  mustBeUnique,
}

class AppError extends Equatable {
  final AppErrorType appErrorType;
  final String message;

  const AppError(this.appErrorType, {this.message = ''});

  @override
  List<Object> get props => [appErrorType, message];
}
