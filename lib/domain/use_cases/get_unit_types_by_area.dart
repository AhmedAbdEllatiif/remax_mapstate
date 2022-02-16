import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/unit_type_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_projects.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetResidentialUnitTypesByAreaCase extends UseCase<List<UnitTypeEntity>, NoParams> {
  final ApiRepo apiRepo;

  GetResidentialUnitTypesByAreaCase({
    required this.apiRepo,
  });

  @override
  Future<Either<AppError, List<UnitTypeEntity>>> call(NoParams params) =>
      apiRepo.getResidentialUnitTypesByArea();
}
