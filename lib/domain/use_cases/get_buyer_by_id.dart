import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/users/user_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

import '../entities/params/fetch_buyer_user_params.dart';

class GetBuyerByIdCase extends UseCase<UserEntity, FetchBuyerUserParams> {
  final RemoteRepository remoteRepository;

  GetBuyerByIdCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, UserEntity>> call(
          FetchBuyerUserParams params) async =>
      await remoteRepository.getBuyerById(params: params);
}
