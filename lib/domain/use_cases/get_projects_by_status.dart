import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/fetch_list_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetProjectsByStatusCase
    extends UseCase<List<ProjectEntity>, FetchListParams> {
  final RemoteRepository apiRepo;

  GetProjectsByStatusCase({
    required this.apiRepo,
  });

  @override
  Future<Either<AppError, List<ProjectEntity>>> call(
          FetchListParams params) async =>
      apiRepo.fetchProjectsByStatus(params);
}
