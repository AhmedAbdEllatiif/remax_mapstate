import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/params/fetch_list_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';
import 'package:remax_mapstate/domain/entities/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/domain/entities/team_support_entity.dart';
import 'package:remax_mapstate/domain/entities/unit_type_entity.dart';

import '../../data/params/fetch_areas_params.dart';

abstract class RemoteRepository {
  ///******************************** Projects ******************************** \\\\
  /// return list of TopProjects
  Future<Either<AppError, List<ProjectEntity>>> fetchProjects();

  /// return list of ResidentialProjects
  Future<Either<AppError, List<ProjectEntity>>> getResidentialProjects(
      int areaId);

  /// return list of CommercialProjects
  Future<Either<AppError, List<ProjectEntity>>> getCommercialProjects(
      int areaId);

  /// return list of FavoriteProjects
  Future<Either<AppError, List<ProjectEntity>>> getFavoriteProject();

  /// return list of areas
  Future<Either<AppError, List<AreaEntity>>> getAreas(FetchAreaParams params);

  /// return list of broker according to specific area
  Future<Either<AppError, List<BrokerEntity>>> getAreaBrokers();

  /// return a list of project status
  Future<Either<AppError, List<ProjectStatusEntity>>> getProjectStatus(
      FetchListParams params);

  /// return a list of unitTypes status
  Future<Either<AppError, List<UnitTypeEntity>>> fetchUnitTypeNames(
      FetchListParams params);

  /// return a list of projects by status
  Future<Either<AppError, List<ProjectEntity>>> fetchProjectsByStatus(
      FetchListParams params);

  ///******************************** Developer Contact ******************************** \\\\
  Future<Either<AppError, ContactDeveloperEntity>> getDeveloperContact(
      String developerId);

  ///******************************** Team Support ******************************** \\\\
  /// return team support
  Future<Either<AppError, TeamSupportEntity>> getTeamSupport();
}
