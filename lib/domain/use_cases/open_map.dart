import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/data/params/open_map_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/repositories/app_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class OpenMapCase extends UseCase<SuccessModel, OpenMapParams> {
  final AppRepository appRepository;

  OpenMapCase({
    required this.appRepository,
  });

  @override
  Future<Either<AppError, SuccessModel>> call(OpenMapParams params) async =>
      appRepository.openMap(openMapParams: params);
}
