import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/update_user_params.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class UpdateDefaultUserCase extends UseCase<void, UpdateDefaultUserParams> {
  final RemoteRepository remoteRepository;

  UpdateDefaultUserCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, UserEntity>> call(
          UpdateDefaultUserParams params) async =>
      remoteRepository.updateDefaultUser(params);
}
