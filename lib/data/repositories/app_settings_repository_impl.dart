import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/data_sources/app_settings_local_data_source.dart';

import 'package:remax_mapstate/domain/entities/app_error.dart';
import '../../domain/repositories/app_settings_repository.dart';

class AppSettingsRepositoryImpl extends AppSettingsRepository {
  final AppSettingsLocalDataSource appSettingsLocalDataSource;

  AppSettingsRepositoryImpl({
    required this.appSettingsLocalDataSource,
  });

  /// return the preferred language of the app
  @override
  Future<Either<AppError, String>> getPreferredLanguage() async {
    try {
      final response = await appSettingsLocalDataSource.getPreferredLanguage();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.localDB));
    }
  }

  /// update current preferred language
  @override
  Future<Either<AppError, void>> updateLanguage(String language) async {
    try {
      final response =
          await appSettingsLocalDataSource.updateLanguage(language);
      return Right(response);
    } on Exception {
      return const Left( AppError(AppErrorType.localDB));
    }
  }
}
