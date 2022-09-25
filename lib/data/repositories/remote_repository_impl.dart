import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/data/data_sources/remote_data_source.dart';
import 'package:remax_mapstate/data/params/fetch_areas_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';
import 'package:remax_mapstate/domain/entities/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/domain/entities/team_support_entity.dart';
import 'package:remax_mapstate/domain/entities/unit_type_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';

import '../params/fetch_unit_type_names.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final RemoteDataSource remoteDataSource;

  RemoteRepositoryImpl({
    required this.remoteDataSource,
  });

  /// return list of TopProject
  @override
  Future<Either<AppError, List<ProjectEntity>>> fetchProjects() async {
    try {
      final projects = await remoteDataSource.fetchProjects();
      print(".........\nProjects: $projects \n.......");
      return Right(projects);
    } on SocketException catch (e) {
      print("Error: SocketException >> $e");
      return Left(AppError(AppErrorType.network, message: e.message));
    } on Exception catch (e) {
      print("Error: Exception >> $e");
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// return list of Areas
  @override
  Future<Either<AppError, List<AreaEntity>>> getAreas(
      FetchAreaParams params) async {
    try {
      final areas = await remoteDataSource.getAreas(params);
      return Right(areas);
    } on SocketException catch (e) {
      return Left(AppError(AppErrorType.network, message: e.message));
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: e.toString()));
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
    } on SocketException catch (e) {
      return Left(AppError(AppErrorType.network, message: e.message));
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<ProjectEntity>>> getCommercialProjects(
      int areaId) async {
    try {
      final projects = await remoteDataSource.getCommercialProjects(areaId);
      return Right(projects);
    } on SocketException catch (e) {
      return Left(AppError(AppErrorType.network, message: e.message));
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// return list residential projects
  @override
  Future<Either<AppError, List<ProjectEntity>>> getResidentialProjects(
      int areaId) async {
    try {
      final projects = await remoteDataSource.getResidentialProjects(areaId);
      return Right(projects);
    } on SocketException catch (e) {
      return Left(AppError(AppErrorType.network, message: e.message));
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// return list project status
  @override
  Future<Either<AppError, List<ProjectStatusEntity>>> getProjectStatus() async {
    try {
      final status = await remoteDataSource.getProjectStatus();
      return Right(status);
    } on SocketException catch (e) {
      return Left(AppError(AppErrorType.network, message: e.message));
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// return list unitTypes status
  @override
  Future<Either<AppError, List<UnitTypeEntity>>> fetchUnitTypeNames(
      FetchUnitTypeNamesParams params) async {
    try {
      final unitTypes = await remoteDataSource.getUnitTypesNames(
        pageInfo: params.pageInfo,
        filtersList: params.filters,
        appLanguage: params.appLanguage,
      );
      return Right(unitTypes);
    } on SocketException catch (e) {
      return Left(AppError(AppErrorType.network, message: e.message));
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// return developer contact data
  @override
  Future<Either<AppError, ContactDeveloperEntity>> getDeveloperContact(
      int developerId) async {
    try {
      final developerDataModel =
          await remoteDataSource.getDeveloperContact(developerId);
      final contactDeveloperEntity =
          ContactDeveloperEntity.fromContactDeveloperModel(developerDataModel);
      return Right(contactDeveloperEntity);
    } on SocketException catch (e) {
      return Left(AppError(AppErrorType.network, message: e.message));
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// return team support data
  @override
  Future<Either<AppError, TeamSupportEntity>> getTeamSupport() async {
    try {
      final teamSupportModel = await remoteDataSource.getTeamSupport();
      final teamSupportEntity = teamSupportModel;
      return Right(teamSupportEntity);
    } on SocketException catch (e) {
      return Left(AppError(AppErrorType.network, message: e.message));
    } on Exception catch (e) {
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }
}
