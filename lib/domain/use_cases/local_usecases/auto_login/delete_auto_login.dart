import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/repositories/app_settings_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class DeleteAutoLogin extends UseCase<void, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  DeleteAutoLogin({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, void>> call(NoParams params) async =>
      appSettingsRepository.deleteAutoLogin();
}
