import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/common/enums/login_status.dart';
import 'package:remax_mapstate/data/data_sources/app_settings_local_data_source.dart';
import 'package:remax_mapstate/domain/entities/auto_login_entity.dart';

import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/users/user_entity.dart';
import '../../domain/entities/authorized_user_entity.dart';
import '../../domain/repositories/app_settings_repository.dart';

class AppSettingsRepositoryImpl extends AppSettingsRepository {
  final AppSettingsLocalDataSource appSettingsDataSource;

  AppSettingsRepositoryImpl({
    required this.appSettingsDataSource,
  });

  //=============================>  User Date   <=============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// deleteCurrentUserData
  @override
  Future<Either<AppError, void>> deleteAuthorizedCurrentUserData() async {
    try {
      final deleteCurrentUser = await appSettingsDataSource.deleteCurrentUser();
      return Right(deleteCurrentUser);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  /// getCurrentUserData
  @override
  Future<Either<AppError, AuthorizedUserEntity>>
      getCurrentAuthorizedUserData() async {
    try {
      final currentUserData = await appSettingsDataSource.getCurrentUser();
      return Right(currentUserData);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  /// saveCurrentUserData
  @override
  Future<Either<AppError, void>> saveCurrentAuthorizedUserData(
      AuthorizedUserEntity authorizedUserEntity) async {
    try {
      final saveCurrentUser =
          await appSettingsDataSource.saveCurrentUser(authorizedUserEntity);
      return Right(saveCurrentUser);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  /// return the preferred language of the app
  @override
  Future<Either<AppError, String>> getPreferredLanguage() async {
    try {
      final response = await appSettingsDataSource.getPreferredLanguage();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.localDB));
    }
  }

  /// update current preferred language
  @override
  Future<Either<AppError, void>> updateLanguage(String language) async {
    try {
      final response = await appSettingsDataSource.updateLanguage(language);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.localDB));
    }
  }

  @override
  Future<Either<AppError, String>> getAutoLoginStatus() async {
    try {
      final autoLoginEntity = await appSettingsDataSource.getAutoLogin();
      return Right(autoLoginEntity.userToken);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  @override
  Future<Either<AppError, void>> saveLoginStatus(
      AutoLoginEntity autoLoginEntity) async {
    try {
      final saveAutoLogin =
          await appSettingsDataSource.saveLoginStatus(autoLoginEntity);
      return Right(saveAutoLogin);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }

  @override
  Future<Either<AppError, void>> deleteAutoLogin() async {
    try {
      final deleteAutoLogin = await appSettingsDataSource.deleteAutoLogin();
      return Right(deleteAutoLogin);
    } on Exception {
      return const Left(AppError(AppErrorType.sharedPreferences));
    }
  }


}
