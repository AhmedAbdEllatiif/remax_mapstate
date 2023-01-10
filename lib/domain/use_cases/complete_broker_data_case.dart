import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/complete_broker_data_params.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class CompleteBrokerDataCase
    extends UseCase<SuccessModel, CompleteBrokerDataParams> {
  final RemoteRepository remoteRepository;

  CompleteBrokerDataCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, SuccessModel>> call(
          CompleteBrokerDataParams params) async =>
      await remoteRepository.completeBrokerData(params);
}
