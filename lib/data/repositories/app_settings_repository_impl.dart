import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/common/enums/login_status.dart';
import 'package:remax_mapstate/data/data_sources/app_settings_local_data_source.dart';
import 'package:remax_mapstate/domain/entities/auto_login_entity.dart';

import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
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
      return const Left(AppError(AppErrorType.localDB));
    }
  }

  /// return currentUser
  @override
  Future<Either<AppError, UserEntity>> getCurrentUser() async {
    try {
      final response = await appSettingsLocalDataSource.getCurrentUser();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.localDB));
    }
  }

  /// update currentUser
  @override
  Future<Either<AppError, void>> updateCurrentUser(
      UserEntity currentUser) async {
    try {
      final response =
          await appSettingsLocalDataSource.saveCurrentUser(currentUser);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.localDB));
    }
  }

  @override
  Future<Either<AppError, LoginStatus>> getAutoLoginStatus() async {
    try {
      final autoLoginEntity = await appSettingsLocalDataSource.getAutoLogin();
      return Right(autoLoginEntity.loginStatus);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  @override
  Future<Either<AppError, void>> saveLoginStatus(
      AutoLoginEntity autoLoginEntity) async {
    try {
      final saveAutoLogin =
          await appSettingsLocalDataSource.saveLoginStatus(autoLoginEntity);
      return Right(saveAutoLogin);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  @override
  Future<Either<AppError, void>> deleteAutoLogin() async {
    try {
      final deleteAutoLogin =
          await appSettingsLocalDataSource.deleteAutoLogin();
      return Right(deleteAutoLogin);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }
}
