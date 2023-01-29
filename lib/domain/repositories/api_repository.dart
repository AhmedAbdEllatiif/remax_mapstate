import 'package:dartz/dartz.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/data/params/add_or_remove_project_to_fav_params.dart';
import 'package:remax_mapstate/data/params/fetch_list_params.dart';
import 'package:remax_mapstate/data/params/filter_data_params.dart';
import 'package:remax_mapstate/data/params/get_profile_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';
import 'package:remax_mapstate/domain/entities/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/filter_data_entity.dart';
import 'package:remax_mapstate/domain/entities/login_entity.dart';
import 'package:remax_mapstate/domain/entities/params/fetch_buyer_user_params.dart';
import 'package:remax_mapstate/domain/entities/params/login_params.dart';
import 'package:remax_mapstate/domain/entities/params/reigster_params.dart';
import 'package:remax_mapstate/domain/entities/params/update_user_after_registration_params.dart';
import 'package:remax_mapstate/domain/entities/params/update_user_params.dart';
import 'package:remax_mapstate/domain/entities/profile_entity.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/domain/entities/register_entity.dart';
import 'package:remax_mapstate/domain/entities/team_support_entity.dart';
import 'package:remax_mapstate/domain/entities/unit_type_entity.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';

import '../../data/params/fetch_areas_params.dart';
import '../../data/params/fetch_broker_params.dart';
import '../../data/params/fetch_favorite_projects_params.dart';
import '../../data/params/update_user_avatar.dart';
import '../entities/params/complete_broker_data_params.dart';
import '../entities/params/contact_us_request_params.dart';

abstract class RemoteRepository {
  ///***************************** Projects ******************************* \\\\
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

  /// return list of areas_by_status
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

  /// return a filter data
  Future<Either<AppError, FilterDataEntity>> fetchFilterData(
      FilterDataParams params);

  /// return a list of projects
  Future<Either<AppError, List<ProjectEntity>>> advancedFilterProjects(
      FetchListParams params);

  ///********************************* Auth ******************************* \\\\
  Future<Either<AppError, UserEntity>> updateDefaultUser(
      UpdateDefaultUserParams params);

  /// registerNewUser
  Future<Either<AppError, RegisterEntity>> registerNewUser(
      RegisterParams params);

  /// getCurrentUserProfile
  Future<Either<AppError, ProfileEntity>> getCurrentUserProfile(
      GetCurrentUserProfileParams params);

  /// login
  Future<Either<AppError, LoginEntity>> loginUser(LoginParams params);

  /// getBrokerProfile
  Future<Either<AppError, UserEntity>> getBrokerById(
      {required FetchBrokerParams params});

  /// getBuyerById
  Future<Either<AppError, UserEntity>> getBuyerById(
      {required FetchBuyerUserParams params});

  /// completeBrokerData
  Future<Either<AppError, SuccessModel>> completeBrokerData(
    CompleteBrokerDataParams params,
  );

  ///****************************** UpdateUser **************************** \\\\
  /// updateUserGroup
  Future<Either<AppError, UserEntity>> updateUserAfterRegistration(
    UpdateUserGroupParams params,
  );

  /// updateUserGroup
  Future<Either<AppError, UserEntity>> uploadUserAvatar(
    UpdateUserAvatarParams params,
  );

  /// addOrRemoveFavProject
  Future<Either<AppError, SuccessModel>> addOrRemoveFavProject(
    AddOrRemoveFavProjectParam params,
  );

  /// fetchFavProjectsIds
  Future<Either<AppError, List<int>>> fetchFavProjectsIds(
    FetchFavoriteProjectsParams params,
  );

  ///**************************** Developer Contact *********************** \\\\
  Future<Either<AppError, ContactDeveloperEntity>> getDeveloperContact(
      String developerId);

  ///**************************** Team Support **************************** \\\\
  /// return team support
  Future<Either<AppError, TeamSupportEntity>> getTeamSupport();

  /// contactUs
  Future<Either<AppError, SuccessModel>> contactUs(
    ContactUsRequestParams params,
  );
}
