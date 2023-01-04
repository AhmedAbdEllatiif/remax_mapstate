import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import '../../../entities/app_error.dart';
import '../../../repositories/app_settings_repository.dart';
import '../../use_case.dart';

class UpdateCurrentUserCase extends UseCase<void, UserEntity> {
  final AppSettingsRepository appSettingsRepository;

  UpdateCurrentUserCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, void>> call(UserEntity params) async =>
      await appSettingsRepository.updateCurrentUser(params);
}
