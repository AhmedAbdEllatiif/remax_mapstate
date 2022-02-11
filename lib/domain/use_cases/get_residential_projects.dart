import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/area_projects_param.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_projects.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetResidentialProjectsCase extends UseCase<List<ProjectEntity>, AreaProjectsParam> {
  final ApiRepo apiRepo;

  GetResidentialProjectsCase({required this.apiRepo});

  @override
  Future<Either<AppError, List<ProjectEntity>>> call(AreaProjectsParam params) async{
    return await apiRepo.getResidentialProjects(params.areaId);
  }
      
}
