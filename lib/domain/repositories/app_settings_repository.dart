import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';

abstract class AppSettingsRepository{

  /// return the preferred language of the app
  Future<Either<AppError, String>> getPreferredLanguage();

  /// update current preferred language
  Future<Either<AppError, void>> updateLanguage(String language);
}