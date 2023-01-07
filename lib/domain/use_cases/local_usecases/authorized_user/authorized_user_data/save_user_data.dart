import 'package:dartz/dartz.dart';

import '../../../../entities/app_error.dart';
import '../../../../entities/authorized_user_entity.dart';
import '../../../../repositories/app_settings_repository.dart';
import '../../../use_case.dart';

class SaveUserDataCase extends UseCase<void, AuthorizedUserEntity> {
  final AppSettingsRepository appSettingsRepository;

  SaveUserDataCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, void>> call(AuthorizedUserEntity params) async =>
      await appSettingsRepository.saveCurrentAuthorizedUserData(params);
}
