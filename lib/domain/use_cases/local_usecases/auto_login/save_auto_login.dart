import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/auto_login_entity.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/repositories/app_settings_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class SaveAutoLogin extends UseCase<void, AutoLoginEntity> {
  final AppSettingsRepository appSettingsRepository;

  SaveAutoLogin({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, void>> call(AutoLoginEntity params) async =>
      appSettingsRepository.saveLoginStatus(params);
}
