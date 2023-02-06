import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/fetch_ambassador_user_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/users/ambassador_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetAmbassadorByIdCase
    extends UseCase<AmbassadorEntity, FetchAmbassadorParams> {
  final RemoteRepository remoteRepository;

  GetAmbassadorByIdCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, AmbassadorEntity>> call(
          FetchAmbassadorParams params) async =>
      await remoteRepository.getAmbassadorById(params: params);
}
