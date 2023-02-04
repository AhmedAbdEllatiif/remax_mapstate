import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/fetch_fav_projects_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

import '../../entities/project_entity.dart';

class GetFavProjectsCase
    extends UseCase<List<ProjectEntity>, FetchFavProjectsParams> {
  final RemoteRepository remoteRepository;

  GetFavProjectsCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, List<ProjectEntity>>> call(
      FetchFavProjectsParams params) async =>
      await remoteRepository.fetchFavProjects(params);
}
