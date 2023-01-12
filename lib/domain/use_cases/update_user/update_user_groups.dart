import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/update_user_group_params.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class UpdateUserGroupCase extends UseCase<UserEntity, UpdateUserGroupParams> {
  final RemoteRepository remoteRepository;

  UpdateUserGroupCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, UserEntity>> call(
          UpdateUserGroupParams params) async =>
      await remoteRepository.updateUserGroup(params);
}
