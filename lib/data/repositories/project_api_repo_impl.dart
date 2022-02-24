import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/data/data_sources/remote_data_source.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';
import 'package:remax_mapstate/domain/entities/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/domain/entities/unit_type_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';

class ProjectApiRepoImpl extends ApiRepo {

  final RemoteDataSource remoteDataSource;

   ProjectApiRepoImpl({
    required this.remoteDataSource,
  });

  /// return list of TopProject
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

  /// return list of Areas
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


  /// return list of FavoriteProject
  @override
  Future<Either<AppError, List<ProjectEntity>>> getFavoriteProject() {
    // TODO: implement getFavoriteProject
    throw UnimplementedError();
  }

  /// return list of area broker
  @override
  Future<Either<AppError, List<BrokerEntity>>> getAreaBrokers() async {
    try {
      final brokers = await remoteDataSource.getAreaBrokers();
      return Right(brokers);
    } on SocketException catch(e){
      return Left(AppError(AppErrorType.network,message: e.message));
    }
    on Exception catch (e) {
      return Left(AppError(AppErrorType.api,message: e.toString()));
    }
  }



  @override
  Future<Either<AppError, List<ProjectEntity>>> getCommercialProjects(int areaId) async {
     try {
    final projects = await remoteDataSource.getCommercialProjects(areaId);
    return Right(projects);
    } on SocketException catch(e){
    return Left(AppError(AppErrorType.network,message: e.message));
    }
    on Exception catch (e) {
    return Left(AppError(AppErrorType.api,message: e.toString()));
    }
  }

  /// return list residential projects
  @override
  Future<Either<AppError, List<ProjectEntity>>> getResidentialProjects(int areaId) async {
    try {
      final projects = await remoteDataSource.getResidentialProjects(areaId);
      return Right(projects);
    } on SocketException catch(e){
      return Left(AppError(AppErrorType.network,message: e.message));
    }
    on Exception catch (e) {
      return Left(AppError(AppErrorType.api,message: e.toString()));
    }
  }

  /// return list project status
  @override
  Future<Either<AppError, List<ProjectStatusEntity>>> getProjectStatus() async {
    try {
      final status = await remoteDataSource.getProjectStatus();
      return Right(status);
    } on SocketException catch(e){
      return Left(AppError(AppErrorType.network,message: e.message));
    }
    on Exception catch (e) {
      return Left(AppError(AppErrorType.api,message: e.toString()));
    }
  }

  /// return list unitTypes status
  @override
  Future<Either<AppError, List<UnitTypeEntity>>> getResidentialUnitTypesByArea() async {
    try {
      final unitTypes = await remoteDataSource.getResidentialUnitTypesByArea();
      return Right(unitTypes);
    } on SocketException catch(e){
      return Left(AppError(AppErrorType.network,message: e.message));
    }
    on Exception catch (e) {
      return Left(AppError(AppErrorType.api,message: e.toString()));
    }
  }

  /// return developer contact data
  @override
  Future<Either<AppError, ContactDeveloperEntity>> getDeveloperContact(int developerId) async {
    try {
      final developerData = await remoteDataSource.getDeveloperContact(developerId);
      return Right(developerData);
    } on SocketException catch(e){
      return Left(AppError(AppErrorType.network,message: e.message));
    }
    on Exception catch (e) {
      return Left(AppError(AppErrorType.api,message: e.toString()));
    }
  }





}
