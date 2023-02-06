import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/common/enums/login_status.dart';
import 'package:remax_mapstate/domain/entities/auto_login_entity.dart';
import 'package:remax_mapstate/domain/entities/users/user_entity.dart';
import '../entities/app_error.dart';
import '../entities/authorized_user_entity.dart';

abstract class AppSettingsRepository {
  /// return the preferred language of the app
  Future<Either<AppError, String>> getPreferredLanguage();

  /// update current preferred language
  Future<Either<AppError, void>> updateLanguage(String language);

  /// save CurrentUserData
  Future<Either<AppError, void>> saveCurrentAuthorizedUserData(
      AuthorizedUserEntity userEntity);

  /// save CurrentUserData
  Future<Either<AppError, void>> deleteAuthorizedCurrentUserData();

  /// return CurrentUserData
  Future<Either<AppError, AuthorizedUserEntity>> getCurrentAuthorizedUserData();

  /// save AutoLoginStatus
  Future<Either<AppError, void>> saveLoginStatus(
      AutoLoginEntity autoLoginEntity);

  /// save AutoLoginStatus
  Future<Either<AppError, void>> deleteAutoLogin();

  /// return AutoLoginStatus
  Future<Either<AppError, String>> getAutoLoginStatus();

  //===========================>  First launch  <=============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\

  /// changeFirstLaunch
  Future<Either<AppError, void>> changeFirstLaunch();

  /// getFirstLaunchStatus
  Future<Either<AppError, bool>> getFirstLaunchStatus();
}
