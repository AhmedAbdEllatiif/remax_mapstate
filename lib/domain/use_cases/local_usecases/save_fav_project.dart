import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/repositories/local_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class SaveFavProject extends UseCase<void, ProjectEntity> {
  final LocalRepository localRepository;

  SaveFavProject({
    required this.localRepository,
  });

  @override
  Future<Either<AppError, void>> call(ProjectEntity params) async =>
      await localRepository.saveFavoriteProject(params);
}
