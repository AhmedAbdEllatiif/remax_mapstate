import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/get_profile_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/profile_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetCurrentUserProfileCase
    extends UseCase<ProfileEntity, GetCurrentUserProfileParams> {
  final RemoteRepository remoteRepository;

  GetCurrentUserProfileCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, ProfileEntity>> call(
          GetCurrentUserProfileParams params) async =>
      await remoteRepository.getCurrentUserProfile(params);
}
