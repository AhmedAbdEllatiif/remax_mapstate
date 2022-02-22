import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:remax_mapstate/data/data_sources/app_settings_local_data_source.dart';
import 'package:remax_mapstate/data/data_sources/local_data_source.dart';
import 'package:remax_mapstate/data/data_sources/remote_data_source.dart';
import 'package:remax_mapstate/data/repositories/app_settings_repository_impl.dart';
import 'package:remax_mapstate/data/repositories/loca_repository_impl.dart';
import 'package:remax_mapstate/data/repositories/project_api_repo_impl.dart';
import 'package:remax_mapstate/domain/repositories/api_projects.dart';
import 'package:remax_mapstate/domain/repositories/app_settings_repository.dart';
import 'package:remax_mapstate/domain/repositories/local_repository.dart';
import 'package:remax_mapstate/domain/use_cases/get_area_brokers.dart';
import 'package:remax_mapstate/domain/use_cases/get_areas.dart';
import 'package:remax_mapstate/domain/use_cases/get_commercial_projects.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/current_user/get_current_user.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/current_user/update_current_user.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/get_preferred_language.dart';
import 'package:remax_mapstate/domain/use_cases/get_project_status.dart';
import 'package:remax_mapstate/domain/use_cases/get_residential_projects.dart';
import 'package:remax_mapstate/domain/use_cases/get_projects.dart';
import 'package:remax_mapstate/domain/use_cases/get_unit_types_by_area.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/check_for_favorite_project.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/delete_fav_project.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/get_fav_projects.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/save_fav_project.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/update_language.dart';

import 'package:remax_mapstate/presentation/bloc/areas_bloc/areas_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/brokers_by_area/area_brokers_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/favorite_projects/favorite_projects_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/login/login_bloc.dart';

import 'package:remax_mapstate/presentation/bloc/project_status/project_status_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/projects/fetch_projects_bloc.dart';
import 'package:remax_mapstate/presentation/cubit/auto_login/auto_login_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/broker_changed/broker_changed_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/change_login_view/change_login_view_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/commercial_projects/commercial_projects_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/count_down_cubit/count_down_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/language/language_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/project_scrollable_indicator/indicator_position_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/residential_projects/residential_projects_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/use_cases/local_usecases/auto_login/delete_auto_login.dart';
import '../domain/use_cases/local_usecases/auto_login/get_auto_login.dart';
import '../domain/use_cases/local_usecases/auto_login/save_auto_login.dart';
import '../presentation/bloc/project_status_backdrop/project_status_backdrop_bloc.dart';
import '../presentation/cubit/current_user/current_user_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  ///********************************** SharedPreferences *********************************************\\\
  getItInstance.registerSingletonAsync<SharedPreferences>(
        () => SharedPreferences.getInstance(),
  );

  ///********************************** DataSource *********************************************\\\
  /// Instance of RemoteDataSource
  getItInstance.registerLazySingleton<RemoteDataSource>(
        () => RemoteDateSourceImpl(),
  );

  ///********************************** Local_DataSource *********************************************\\\

  /// Instance of LocalDataSource
  getItInstance.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImpl(),
  );

  /// Instance of AppSettingsLocalDataSource
  getItInstance.registerLazySingleton<AppSettingsLocalDataSource>(
        () => AppSettingsLocalDataSourceImpl(),
  );

  ///********************************** Repositories *********************************************\\\

  /// Instance of ProjectsApiRepo
  getItInstance.registerLazySingleton<ApiRepo>(
        () =>
        ProjectApiRepoImpl(
          remoteDataSource: getItInstance(),
        ),
  );

  ///********************************** Local_Repositories *********************************************\\\
  /// Instance of LocalRepository
  getItInstance.registerLazySingleton<LocalRepository>(
        () =>
        LocalRepositoryImpl(
          localDataSource: getItInstance(),
        ),
  );

  /// Instance of AppSettingsRepository
  getItInstance.registerLazySingleton<AppSettingsRepository>(
        () =>
        AppSettingsRepositoryImpl(
          appSettingsLocalDataSource: getItInstance(),
        ),
  );

  ///********************************** Remote_Use_Cases *********************************************\\\

  /// GetAutoLogin
  getItInstance.registerLazySingleton<GetAutoLogin>(() =>
      GetAutoLogin(appSettingsRepository: getItInstance(),));

  /// SaveAutoLogin
  getItInstance.registerLazySingleton<SaveAutoLogin>(() =>
      SaveAutoLogin(appSettingsRepository: getItInstance(),));


  /// DeleteAutoLogin
  getItInstance.registerLazySingleton<DeleteAutoLogin>(() =>
      DeleteAutoLogin(appSettingsRepository: getItInstance(),));

  /// GetTopProjects
  getItInstance.registerLazySingleton<GetProjectsCase>(
        () => GetProjectsCase(projectApiRepo: getItInstance()),
  );

  /// GetAreasCase
  getItInstance.registerLazySingleton<GetAreasCase>(
        () =>
        GetAreasCase(
          projectApiRepo: getItInstance(),
        ),
  );

  /// GetAreasBrokersCase
  getItInstance.registerLazySingleton<GetAreaBrokersCase>(
        () =>
        GetAreaBrokersCase(
          apiRepo: getItInstance(),
        ),
  );

  /// GetResidentialProjectsCase
  getItInstance.registerLazySingleton<GetResidentialProjectsCase>(
        () =>
        GetResidentialProjectsCase(
          apiRepo: getItInstance(),
        ),
  );

  /// GetCommercialProjectsCase
  getItInstance.registerLazySingleton<GetCommercialProjectsCase>(
        () =>
        GetCommercialProjectsCase(
          apiRepo: getItInstance(),
        ),
  );

  /// GetProjectStatusCase
  getItInstance.registerLazySingleton<GetProjectStatusCase>(
        () =>
        GetProjectStatusCase(
          apiRepo: getItInstance(),
        ),
  );

  /// GetProjectStatusCase
  getItInstance.registerLazySingleton<GetResidentialUnitTypesByAreaCase>(
        () =>
        GetResidentialUnitTypesByAreaCase(
          apiRepo: getItInstance(),
        ),
  );

  ///********************************** Local_Use_Cases *********************************************\\\

  /// GetPreferredLanguage
  getItInstance.registerLazySingleton<GetPreferredLanguage>(
          () => GetPreferredLanguage(appSettingsRepository: getItInstance()));

  /// UpdateLanguage
  getItInstance.registerLazySingleton<UpdateLanguage>(
          () => UpdateLanguage(appSettingsRepository: getItInstance()));

  /// GetCurrentUserCase
  getItInstance.registerLazySingleton<GetCurrentUserCase>(
          () => GetCurrentUserCase(appSettingsRepository: getItInstance()));

  /// UpdateCurrentUserCase
  getItInstance.registerLazySingleton<UpdateCurrentUserCase>(
          () => UpdateCurrentUserCase(appSettingsRepository: getItInstance()));

  /// GetFavProject
  getItInstance.registerLazySingleton<GetFavProjects>(
          () => GetFavProjects(localRepository: getItInstance()));

  /// DeleteFavProject
  getItInstance.registerLazySingleton<DeleteFavProject>(
          () => DeleteFavProject(localRepository: getItInstance()));

  /// SaveFavProject
  getItInstance.registerLazySingleton<SaveFavProject>(
          () => SaveFavProject(localRepository: getItInstance()));

  /// CheckForFavProject
  getItInstance.registerLazySingleton<CheckForFavProjectUseCase>(
          () => CheckForFavProjectUseCase(localRepository: getItInstance()));

  ///********************************** init cubit *********************************************\\\

  /// init AutoLoginCubit
  getItInstance.registerSingleton<AutoLoginCubit>(
    AutoLoginCubit(
      getAutoLogin: getItInstance(),
      saveAutoLogin: getItInstance(),
      deleteAutoLogin: getItInstance(),
    ),
  );

  /// init navigation cubit
  getItInstance.registerFactory<NavigationCubit>(() => NavigationCubit());

  /// init CurrentUserCubit
  getItInstance.registerSingleton<CurrentUserCubit>(
    CurrentUserCubit(
      getCurrentUserCase: getItInstance(),
      updateCurrentUserCase: getItInstance(),
    ),
  );

  /// init BrokerChangeCubit
  getItInstance.registerFactory<BrokerChangedCubit>(
        () => BrokerChangedCubit(),
  );

  /// init ResidentialProjectsCubit
  getItInstance.registerFactory<ResidentialCubit>(
        () =>
        ResidentialCubit(
          residentialProjectsCase: getItInstance(),
          getUnitTypesByAreaCase: getItInstance(),
        ),
  );

  /// init CommercialProjectsCubit
  getItInstance.registerFactory<CommercialProjectsCubit>(
        () =>
        CommercialProjectsCubit(
          commercialProjectsCase: getItInstance(),
        ),
  );

  /// init LanguageCubit
  getItInstance.registerSingleton<LanguageCubit>(
    LanguageCubit(
      getPreferredLanguage: getItInstance(),
      updateLanguage: getItInstance(),
    ),
  );

  /// init CountDownCubit
  getItInstance.registerFactory(
        () => CountDownCubit(),
  );

  /// init ChangeLoginViewCubit
  getItInstance.registerFactory<ChangeLoginViewCubit>(
        () => ChangeLoginViewCubit(),
  );

  ///********************************** init blocs *********************************************\\\

  ///==> init LoginBloc
  getItInstance.registerFactory<LoginBloc>(
        () => LoginBloc(countDownCubit: getItInstance()),
  );

  ///==> init ProjectBackdropBloc
  getItInstance.registerFactory<ProjectStatusBackdropBloc>(
        () => ProjectStatusBackdropBloc(),
  );

  ///==> init ProjectStatusBloc
  getItInstance.registerFactory<ProjectStatusBloc>(
        () =>
        ProjectStatusBloc(
          backdropBloc: getItInstance(),
          getProjectStatusCase: getItInstance(),
        ),
  );

  ///==> init FetchProjectsBloc
  getItInstance.registerFactory<FetchProjectsBloc>(() =>
      FetchProjectsBloc(
        getProjects: getItInstance(),
      ));

  /// init areas bloc
  getItInstance.registerFactory<AreasBloc>(
        () =>
        AreasBloc(
          getAreas: getItInstance(),
        ),
  );

  /// init favoriteProjects bloc
  getItInstance.registerFactory<FavoriteProjectsBloc>(
        () =>
        FavoriteProjectsBloc(
          getFavProjects: getItInstance(),
          deleteFavProject: getItInstance(),
          saveFavProject: getItInstance(),
          checkForFavProject: getItInstance(),
        ),
  );

  /// init IndicatorPositionCubit
  getItInstance
      .registerFactory<IndicatorPositionCubit>(() => IndicatorPositionCubit());

  /// init AreaBrokersBloc
  getItInstance.registerFactory<AreaBrokersBloc>(
          () => AreaBrokersBloc(getAreaBrokersCase: getItInstance()));
}
