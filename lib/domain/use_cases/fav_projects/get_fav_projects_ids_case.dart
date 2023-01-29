import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

import '../../../data/params/fetch_favorite_projects_params.dart';

class GetFavProjectsIdsCase
    extends UseCase<List<int>, FetchFavoriteProjectsParams> {
  final RemoteRepository remoteRepository;

  GetFavProjectsIdsCase({
    required this.remoteRepository,
  });

  @override
  Future<Either<AppError, List<int>>> call(
          FetchFavoriteProjectsParams params) async =>
      await remoteRepository.fetchFavProjectsIds(params);
}
