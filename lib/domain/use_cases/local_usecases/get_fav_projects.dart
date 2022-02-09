import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/repositories/local_repository.dart';
import 'package:remax_mapstate/domain/use_cases/use_case.dart';

class GetFavProjects extends UseCase<List<ProjectEntity>, NoParams> {

  final LocalRepository localRepository;

  GetFavProjects({
    required this.localRepository,
  });


  @override
  Future<Either<AppError, List<ProjectEntity>>> call(NoParams params) async => await localRepository.getFavoriteProjects();

}