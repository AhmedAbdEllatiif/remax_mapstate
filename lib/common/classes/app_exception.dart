import '../enums/api_errors.dart';

class AppException implements Exception {
  AppException({required ApiError apiError});

  factory AppException.add({required ApiError apiError, String message = ""}) {
    return AppException(apiError: apiError);
  }


}
