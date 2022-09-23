import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetProjectStatusCase extends UseCase<List<ProjectStatusEntity>,NoParams>{

  final RemoteRepository apiRepo;


   GetProjectStatusCase({
    required this.apiRepo,
  });

  @override
  Future<Either<AppError, List<ProjectStatusEntity>>> call(NoParams params) async =>
      apiRepo.getProjectStatus();

}