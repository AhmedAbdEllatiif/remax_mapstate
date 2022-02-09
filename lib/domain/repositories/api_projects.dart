import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

abstract class ProjectApiRepo {

  /// return list of TopProjects
  Future<Either<AppError,List<ProjectEntity>>> getTopProject();

  /// return list of areas
  Future<Either<AppError,List<AreaEntity>>> getAreas();



  /// return list of FavoriteProjects
  Future<Either<AppError,List<ProjectEntity>>> getFavoriteProject();

}