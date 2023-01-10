import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:remax_mapstate/data/data_sources/remote_data_source.dart';
import 'package:remax_mapstate/data/models/mutation/login/login_request_model.dart';
import 'package:remax_mapstate/data/models/mutation/login/login_response_model.dart';
import 'package:remax_mapstate/data/models/mutation/update_broker_request_model.dart';
import 'package:remax_mapstate/data/models/mutation/update_user.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/data/models/user_model.dart';
import 'package:remax_mapstate/data/params/fetch_areas_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/entities/arguments/complete_broker_data_arguments.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';
import 'package:remax_mapstate/domain/entities/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/filter_data_entity.dart';
import 'package:remax_mapstate/domain/entities/params/complete_broker_data_params.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/domain/entities/team_support_entity.dart';
import 'package:remax_mapstate/domain/entities/unit_type_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';

import '../../common/classes/handle_operation_exceptions.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/params/login_params.dart';
import '../../domain/entities/params/update_user_params.dart';
import '../../domain/entities/user_entity.dart';
import '../params/fetch_broker_params.dart';
import '../params/fetch_list_params.dart';
import '../params/filter_data_params.dart';

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
      log("RepoImpl >> getAreas >> SocketException >> $e");
      return Left(AppError(AppErrorType.network, message: e.message));
    } on Exception catch (e) {
      log("RepoImpl >> getAreas >> Exception >> $e");
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
    } on OperationException catch (e) {
      log("RepoImpl >> fetchUnitTypeNames >> OperationException >> $e");
      return Left(AppError(AppErrorType.network, message: e.toString()));
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
  Future<Either<AppError, List<ProjectStatusEntity>>> getProjectStatus(
      FetchListParams params) async {
    try {
      final status = await remoteDataSource.getProjectStatus(
        pageInfo: params.pageInfo,
        filtersList: params.filters,
        appLanguage: params.appLanguage,
      );
      return Right(status);
    } on SocketException catch (e) {
      log("RepoImpl >> getProjectStatus >> SocketException >> $e");
      return Left(AppError(AppErrorType.network, message: e.message));
    } on OperationException catch (e) {
      log("RepoImpl >> getProjectStatus >> OperationException >> $e");
      return Left(AppError(AppErrorType.network, message: e.toString()));
    } on Exception catch (e) {
      log("RepoImpl >> getProjectStatus >> Exception >> $e");
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// return list unitTypes status
  @override
  Future<Either<AppError, List<UnitTypeEntity>>> fetchUnitTypeNames(
      FetchListParams params) async {
    try {
      final unitTypes = await remoteDataSource.getUnitTypesNames(
        pageInfo: params.pageInfo,
        filtersList: params.filters,
        appLanguage: params.appLanguage,
      );
      return Right(unitTypes);
    } on SocketException catch (e) {
      log("RepoImpl >> fetchUnitTypeNames >> SocketException >> $e");
      return Left(AppError(AppErrorType.network, message: e.message));
    } on OperationException catch (e) {
      log("RepoImpl >> fetchUnitTypeNames >> OperationException >> $e");
      return Left(AppError(AppErrorType.network, message: e.toString()));
    } on Exception catch (e) {
      log("RepoImpl >> fetchUnitTypeNames >> Exception >> $e");
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// return developer contact data
  @override
  Future<Either<AppError, ContactDeveloperEntity>> getDeveloperContact(
      String developerId) async {
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

  /// return a list of projects by their status
  @override
  Future<Either<AppError, List<ProjectEntity>>> fetchProjectsByStatus(
      FetchListParams params) async {
    try {
      final projectList = await remoteDataSource.getProjectByStatus(
        pageInfo: params.pageInfo,
        filtersList: params.filters,
        appLanguage: params.appLanguage,
      );
      return Right(projectList);
    } on SocketException catch (e) {
      log("RepoImpl >> fetchProjectsByStatus >> SocketException >> $e");
      return Left(AppError(AppErrorType.network, message: e.message));
    } on OperationException catch (e) {
      log("RepoImpl >> fetchProjectsByStatus >> OperationException >> $e");
      return Left(AppError(AppErrorType.network, message: e.toString()));
    } on Exception catch (e) {
      log("RepoImpl >> fetchProjectsByStatus >> Exception >> $e");
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// fetchFilterData
  @override
  Future<Either<AppError, FilterDataEntity>> fetchFilterData(
      FilterDataParams params) async {
    try {
      final filterData = await remoteDataSource.getFilterDataModel(
        appLanguage: params.appLanguage,
      );
      return Right(filterData);
    } on SocketException catch (e) {
      log("RepoImpl >> fetchFilterData >> SocketException >> $e");
      return Left(AppError(AppErrorType.network, message: e.message));
    } on OperationException catch (e) {
      log("RepoImpl >> fetchFilterData >> OperationException >> $e");
      return Left(AppError(AppErrorType.network, message: e.toString()));
    } on Exception catch (e) {
      log("RepoImpl >> fetchFilterData >> Exception >> $e");
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// advancedFilterProjects
  @override
  Future<Either<AppError, List<ProjectEntity>>> advancedFilterProjects(
      FetchListParams params) async {
    try {
      final projectList = await remoteDataSource.advancedFilterProject(
        pageInfo: params.pageInfo,
        filtersList: params.filters,
        appLanguage: params.appLanguage,
      );
      return Right(projectList);
    } on SocketException catch (e) {
      log("RepoImpl >> fetchProjectsByStatus >> SocketException >> $e");
      return Left(AppError(AppErrorType.network, message: e.message));
    } on OperationException catch (e) {
      log("RepoImpl >> fetchProjectsByStatus >> OperationException >> $e");
      return Left(AppError(AppErrorType.network, message: e.toString()));
    } on Exception catch (e) {
      log("RepoImpl >> fetchProjectsByStatus >> Exception >> $e");
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /*
  *
  *
  * updateDefaultUser
  *
  *
  * */
  @override
  Future<Either<AppError, UserEntity>> updateDefaultUser(
      UpdateDefaultUserParams params) async {
    try {
      final result = await remoteDataSource.updateDefaultUser(
        updateUserMutationModel: UpdateUserMutationModel.forRegistration(
          email: params.email,
          firstName: params.firstName,
          phoneNumber: params.phoneNumber,
          password: params.password,
          groups: params.groupId,
        ),
      );
      if (result is UserModel) {
        return Right(result);
      }
      return Left(result);
    }
    //==> SocketException
    on SocketException catch (e) {
      log("RepoImpl >> updateCurrentUser >> SocketException >> $e");
      return Left(AppError(AppErrorType.network, message: e.message));
    }
    //==> OperationException
    on OperationException catch (e) {
      final appErrorType =
          AppErrorTypeBuilder.formOperationException(e).appErrorType;
      log("RepoImpl >> updateCurrentUser >> OperationException >> $e");
      return Left(AppError(appErrorType, message: e.toString()));
    }
    //==> Exception
    on Exception catch (e) {
      log("RepoImpl >> updateCurrentUser >> Exception >> $e");
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// loginUser
  @override
  Future<Either<AppError, LoginEntity>> loginUser(LoginParams params) async {
    try {
      final result = await remoteDataSource.loginUser(
        loginRequestModel: LoginRequestModel(
          email: params.email,
          password: params.password,
        ),
      );

      if (result is LoginResponseModel) {
        return Right(result);
      }
      return Left(result);
    }
    //==> SocketException
    on SocketException catch (e) {
      log("RepoImpl >> updateCurrentUser >> SocketException >> $e");
      return Left(AppError(AppErrorType.network, message: e.message));
    }
    //==> OperationException
    on OperationException catch (e) {
      final appErrorType =
          AppErrorTypeBuilder.formOperationException(e).appErrorType;
      log("RepoImpl >> updateCurrentUser >> OperationException >> $e");
      return Left(AppError(appErrorType, message: e.toString()));
    }
    //==> Exception
    on Exception catch (e) {
      log("RepoImpl >> updateCurrentUser >> Exception >> $e");
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  @override
  Future<Either<AppError, UserEntity>> getBrokerById({
    required FetchBrokerParams params,
  }) async {
    try {
      final result = await remoteDataSource.getBrokerById(params: params);

      if (result is List<UserModel>) {
        if (result.isNotEmpty) {
          return Right(result[0]);
        }
      }
      return Left(result);
    }
    //==> SocketException
    on SocketException catch (e) {
      log("RepoImpl >> updateCurrentUser >> SocketException >> $e");
      return Left(AppError(AppErrorType.network, message: e.message));
    }
    //==> OperationException
    on OperationException catch (e) {
      final appErrorType =
          AppErrorTypeBuilder.formOperationException(e).appErrorType;
      log("RepoImpl >> updateCurrentUser >> OperationException >> $e");
      return Left(AppError(appErrorType, message: e.toString()));
    }
    //==> Exception
    on Exception catch (e) {
      log("RepoImpl >> updateCurrentUser >> Exception >> $e");
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }

  /// completeBrokerData
  @override
  Future<Either<AppError, SuccessModel>> completeBrokerData(
      CompleteBrokerDataParams params) async {
    try {
      final result = await remoteDataSource.updateBrokerData(
          updateBrokerRequestModel: UpdateBrokerRequestModel(
        id: params.brokerId,
        experienceYears: params.experienceYears,
        favoriteRegions: params.favoriteRegions,
      ));

      if (result is SuccessModel) {
        return Right(result);
      }
      return Left(result);
    }
    //==> SocketException
    on SocketException catch (e) {
      log("RepoImpl >> completeBrokerData >> SocketException >> $e");
      return Left(AppError(AppErrorType.network, message: e.message));
    }
    //==> OperationException
    on OperationException catch (e) {
      final appErrorType =
          AppErrorTypeBuilder.formOperationException(e).appErrorType;
      log("RepoImpl >> completeBrokerData >> OperationException >> $e");
      return Left(AppError(appErrorType, message: e.toString()));
    }
    //==> Exception
    on Exception catch (e) {
      log("RepoImpl >> completeBrokerData >> Exception >> $e");
      return Left(AppError(AppErrorType.api, message: e.toString()));
    }
  }
}
