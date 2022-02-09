import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/tables/fav_project_table.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

abstract class LocalRepository{

  /// To retrieve Projects from local db
  Future<Either<AppError,List<FavProjectTable>>> getFavoriteProjects();

  /// To save a new Project into local db
  Future<Either<AppError,void>> saveFavoriteProject(ProjectEntity projectEntity);

  /// To delete a Project from local db
  Future<Either<AppError,void>> deleteFavoriteProject(int projectId);

  /// to check if the Project is a favorite Project or not
  Future<Either<AppError,bool>> checkIfProjectIsFavorite(int projectId);


}