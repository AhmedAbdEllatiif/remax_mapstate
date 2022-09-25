import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/fetch_areas_params.dart';
import 'package:remax_mapstate/data/params/fetch_areas_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import '../entities/params/no_params.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetAreasCase extends UseCase<List<AreaEntity>, FetchAreaParams> {
  final RemoteRepository projectApiRepo;

  GetAreasCase({
    required this.projectApiRepo,
  });

  @override
  Future<Either<AppError, List<AreaEntity>>> call(FetchAreaParams params) =>
      projectApiRepo.getAreas(params);
}
