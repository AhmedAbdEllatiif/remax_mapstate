import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/repositories/app_settings_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

import '../../entities/app_error.dart';
import '../../entities/params/no_params.dart';

class GetPreferredLanguage extends UseCase<String, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  GetPreferredLanguage({required this.appSettingsRepository});

  @override
  Future<Either<AppError, String>> call(NoParams params) async =>
      await appSettingsRepository.getPreferredLanguage();
}
