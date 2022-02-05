import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

abstract class ProjectApiRepo {

  /// return list of TopProjects
  Future<Either<AppError,List<ProjectEntity>>> getTopProject();
}