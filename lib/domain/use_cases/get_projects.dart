import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import '../entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetProjectsCase extends UseCase<List<ProjectEntity>, NoParams> {
  final RemoteRepository projectApiRepo;

  GetProjectsCase({required this.projectApiRepo});

  @override
  Future<Either<AppError, List<ProjectEntity>>> call(NoParams params) async =>
      await projectApiRepo.fetchProjects();
}
