import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/project_param_entity.dart';
import 'package:remax_mapstate/domain/repositories/local_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class CheckForFavProjectUseCase extends UseCase<bool, ProjectParamEntity> {
  final LocalRepository localRepository;

  CheckForFavProjectUseCase({
    required this.localRepository,
  });

  @override
  Future<Either<AppError, bool>> call(ProjectParamEntity params) async =>
      await localRepository.checkIfProjectIsFavorite(params.projectId);
}
