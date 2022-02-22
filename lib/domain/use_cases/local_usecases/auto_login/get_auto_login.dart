import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/common/enums/login_status.dart';
import 'package:remax_mapstate/domain/entities/auto_login_entity.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/repositories/app_settings_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetAutoLogin extends UseCase<LoginStatus, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  GetAutoLogin({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, LoginStatus>> call(NoParams params) async =>
      appSettingsRepository.getAutoLoginStatus();
}
