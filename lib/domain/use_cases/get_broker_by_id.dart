import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

import '../../data/params/fetch_broker_params.dart';

class GetBrokerByIdCase extends UseCase<UserEntity, FetchBrokerParams> {
  final RemoteRepository remoteRepository;

  GetBrokerByIdCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, UserEntity>> call(FetchBrokerParams params) async =>
      await remoteRepository.getBrokerById(params: params);
}
