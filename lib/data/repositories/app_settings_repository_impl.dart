import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/data_sources/app_settings_local_data_source.dart';

import 'package:remax_mapstate/domain/entities/app_error.dart';
import '../../common/enums/user_types.dart';
import '../../domain/repositories/app_settings_repository.dart';
import '../tables/current_user_table.dart';

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

  /// return currentUser
  @override
  Future<Either<AppError, CurrentUserTable>> getCurrentUser() async{
    try {
      final response = await appSettingsLocalDataSource.getCurrentUser();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.localDB));
    }
  }

  /// update currentUser
  @override
  Future<Either<AppError, void>> updateCurrentUser(CurrentUserTable currentUser) async {
    try {
      final response =
          await appSettingsLocalDataSource.updateCurrentUser(currentUser);
      return Right(response);
    } on Exception {
      return const Left( AppError(AppErrorType.localDB));
    }
  }
}
