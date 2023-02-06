import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/data/params/update_ambassador_data_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class UpdateAmbassadorDataCase extends UseCase<void, UpdateAmbassadorDataParams> {
  final RemoteRepository remoteRepository;

  UpdateAmbassadorDataCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, SuccessModel>> call(
          UpdateAmbassadorDataParams params) async =>
      remoteRepository.updateAmbassadorData(params: params);
}
