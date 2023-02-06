import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/get_brokers_by_area_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/users/user_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetBrokersByRegionCase
    extends UseCase<List<UserEntity>, GetBrokersByAreaParams> {
  final RemoteRepository remoteRepository;

  GetBrokersByRegionCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, List<UserEntity>>> call(
          GetBrokersByAreaParams params) async =>
      await remoteRepository.getBrokersByRegion(params: params);
}
