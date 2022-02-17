import 'package:dartz/dartz.dart';


import '../../../../data/tables/current_user_table.dart';
import '../../../entities/app_error.dart';
import '../../../repositories/app_settings_repository.dart';
import '../../use_case.dart';

class UpdateCurrentUserCase extends UseCase<void, CurrentUserTable> {
  final AppSettingsRepository appSettingsRepository;

  UpdateCurrentUserCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, void>> call(CurrentUserTable params) async =>
      await appSettingsRepository.updateCurrentUser(params);
}
