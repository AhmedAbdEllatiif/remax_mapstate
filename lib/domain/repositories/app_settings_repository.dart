import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/common/enums/login_status.dart';
import 'package:remax_mapstate/domain/entities/auto_login_entity.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import '../entities/app_error.dart';

abstract class AppSettingsRepository {
  /// return the preferred language of the app
  Future<Either<AppError, String>> getPreferredLanguage();

  /// update current preferred language
  Future<Either<AppError, void>> updateLanguage(String language);

  /// return the currentUser
  Future<Either<AppError, UserEntity>> getCurrentUser();

  /// update currentUser
  Future<Either<AppError, void>> updateCurrentUser(
      UserEntity currentUser);

  /// save AutoLoginStatus
  Future<Either<AppError, void>> saveLoginStatus(
      AutoLoginEntity autoLoginEntity);

  /// save AutoLoginStatus
  Future<Either<AppError, void>> deleteAutoLogin();

  /// return AutoLoginStatus
  Future<Either<AppError, LoginStatus>> getAutoLoginStatus();
}
