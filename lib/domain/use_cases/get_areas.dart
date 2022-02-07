import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/entities/no_params.dart';
import 'package:remax_mapstate/domain/repositories/api_projects.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetAreasCase extends UseCase<List<AreaEntity>, NoParams> {
  final ProjectApiRepo projectApiRepo;

  GetAreasCase({
    required this.projectApiRepo,
  });

  @override
  Future<Either<AppError, List<AreaEntity>>> call(NoParams params) =>
      projectApiRepo.getAreas();
}
