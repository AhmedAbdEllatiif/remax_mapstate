import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/data/data_sources/remote_data_source.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_projects.dart';

class ProjectApiRepoImpl extends ProjectApiRepo {

  final RemoteDataSource remoteDataSource;

   ProjectApiRepoImpl({
    required this.remoteDataSource,
  });

  /// return list of top project
  @override
  Future<Either<AppError, List<ProjectEntity>>> getTopProject() async {
    try {
      final projects = await remoteDataSource.getTopProjects();
      return Right(projects);
    } on SocketException catch(e){
      return Left(AppError(AppErrorType.network,message: e.message));
    }
    on Exception catch (e) {
      return Left(AppError(AppErrorType.api,message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<AreaEntity>>> getAreas() async {
    try {
      final areas = await remoteDataSource.getAreas();
      return Right(areas);
    } on SocketException catch(e){
      return Left(AppError(AppErrorType.network,message: e.message));
    }
    on Exception catch (e) {
      return Left(AppError(AppErrorType.api,message: e.toString()));
    }
  }


}
