import 'package:dartz/dartz.dart';

import '../../../../entities/app_error.dart';
import '../../../../entities/authorized_user_entity.dart';
import '../../../../entities/params/no_params.dart';
import '../../../../repositories/app_settings_repository.dart';
import '../../../use_case.dart';

class GetUserDataCase extends UseCase<AuthorizedUserEntity, NoParams> {
  final AppSettingsRepository appSettingsRepository;

  GetUserDataCase({
    required this.appSettingsRepository,
  });

  @override
  Future<Either<AppError, AuthorizedUserEntity>> call(NoParams params) async =>
      await appSettingsRepository.getCurrentAuthorizedUserData();
}
