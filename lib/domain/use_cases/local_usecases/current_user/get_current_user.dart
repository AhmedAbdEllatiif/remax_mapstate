import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/repositories/app_settings_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';


import '../../../../data/tables/current_user_table.dart';

class GetCurrentUserCase extends UseCase<CurrentUserTable, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  GetCurrentUserCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, CurrentUserTable>> call(NoParams params) async =>
      await appSettingsRepository.getCurrentUser();
}
