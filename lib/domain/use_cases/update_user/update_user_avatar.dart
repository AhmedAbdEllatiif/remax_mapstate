import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/update_user_avatar.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class UpdateUserAvatarCase extends UseCase<UserEntity, UpdateUserAvatarParams> {
  final RemoteRepository remoteRepository;

  UpdateUserAvatarCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, UserEntity>> call(
          UpdateUserAvatarParams params) async =>
      await remoteRepository.uploadUserAvatar(params);
}
