import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_projects.dart';

class ProjectApiRepoImpl extends ProjectApiRepo {



  /// return list of top project
  @override
  Future<Either<AppError, List<ProjectEntity>>> getTopProject() async {
    try {
      //final movies = await remoteDataSource.getComingSoon();
      final projects = [
        const ProjectEntity(id: 0, imageUrl: AssetsConstants.mountainViewImagePath, name: "Mountain View", description: "No Desc"),
        const ProjectEntity(id: 1, imageUrl: AssetsConstants.promotionImagePath, name: "Promotion", description: "No Desc"),
        const ProjectEntity(id: 2, imageUrl: AssetsConstants.mountainViewImagePath, name: "Mountain View", description: "No Desc"),
        const ProjectEntity(id: 3, imageUrl: AssetsConstants.promotionImagePath, name: "Promotion", description: "No Desc"),
        const ProjectEntity(id: 4, imageUrl: AssetsConstants.mountainViewImagePath, name: "Mountain View", description: "No Desc"),
        const ProjectEntity(id: 5, imageUrl: AssetsConstants.promotionImagePath, name: "Promotion", description: "No Desc"),
        const ProjectEntity(id: 6, imageUrl: AssetsConstants.mountainViewImagePath, name: "Mountain View", description: "No Desc"),
        const ProjectEntity(id: 7, imageUrl: AssetsConstants.promotionImagePath, name: "Promotion", description: "No Desc"),
        const ProjectEntity(id: 8, imageUrl: AssetsConstants.mountainViewImagePath, name: "Mountain View", description: "No Desc"),
        const ProjectEntity(id: 9, imageUrl: AssetsConstants.promotionImagePath, name: "Promotion", description: "No Desc"),
        const ProjectEntity(id: 10, imageUrl: AssetsConstants.mountainViewImagePath, name: "Mountain View", description: "No Desc"),
      ];
      return Right(projects);
    } on SocketException catch(e){
      return Left(AppError(AppErrorType.network,message: e.message));
    }
    on Exception catch (e) {
      return Left(AppError(AppErrorType.api,message: e.toString()));
    }
  }
}
