import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/data_sources/local_data_source.dart';
import 'package:remax_mapstate/data/tables/fav_project_table.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/fav_project_entity.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/repositories/local_repository.dart';

class LocalRepositoryImpl extends LocalRepository{

  final LocalDataSource localDataSource;


  LocalRepositoryImpl({
    required this.localDataSource,
  });


  /// To check if project is favorite
  @override
  Future<Either<AppError, bool>> checkIfProjectIsFavorite(int projectId) async {
    try {
      final isSaved = await localDataSource.checkIfProjectIsFavorite(projectId);
      return Right(isSaved);
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.localDB, message: e.toString()));
    }
  }

  /// To delete project from favoriteProjects
  @override
  Future<Either<AppError, void>> deleteFavoriteProject(int projectId) async {
    try {
      final response = await localDataSource.deleteProject(projectId);
      return Right(response);
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.localDB, message: e.toString()));
    }
  }


  /// To retrieve favoriteProjects for localDB
  @override
  Future<Either<AppError, List<FavProjectTable>>> getFavoriteProjects() async {
    try {
      final projects = await localDataSource.getFavProject();
      return Right(projects);
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.localDB, message: e.toString()));
    }
  }


  /// To save a project into favoriteProjects localDB
  @override
  Future<Either<AppError, void>> saveFavoriteProject(FavProjectEntity projectEntity) async {
    try {
      final response = await localDataSource.saveProject(FavProjectTable.fromProjectEntity(projectEntity));
      return Right(response);
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.localDB, message: e.toString()));
    }
  }


}