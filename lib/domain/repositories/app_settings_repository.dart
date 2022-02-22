import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/common/enums/login_status.dart';
import 'package:remax_mapstate/domain/entities/auto_login_entity.dart';
import '../../data/tables/current_user_table.dart';
import '../entities/app_error.dart';

abstract class AppSettingsRepository{

  /// return the preferred language of the app
  Future<Either<AppError, String>> getPreferredLanguage();

  /// update current preferred language
  Future<Either<AppError, void>> updateLanguage(String language);




  /// return the currentUser
  Future<Either<AppError, CurrentUserTable>> getCurrentUser();

  /// update currentUser
  Future<Either<AppError, void>> updateCurrentUser(CurrentUserTable currentUser);


  /// save AutoLoginStatus
  Future<Either<AppError,void>> saveLoginStatus(AutoLoginEntity autoLoginEntity);

  /// save AutoLoginStatus
  Future<Either<AppError,void>> deleteAutoLogin();


  /// return AutoLoginStatus
  Future<Either<AppError,LoginStatus>> getAutoLoginStatus();

}
