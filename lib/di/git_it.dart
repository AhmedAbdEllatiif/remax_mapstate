import 'package:get_it/get_it.dart';
import 'package:remax_mapstate/data/data_sources/local_data_source.dart';
import 'package:remax_mapstate/data/data_sources/remote_data_source.dart';
import 'package:remax_mapstate/data/repositories/loca_repository_impl.dart';
import 'package:remax_mapstate/data/repositories/project_api_repo_impl.dart';
import 'package:remax_mapstate/domain/repositories/api_projects.dart';
import 'package:remax_mapstate/domain/repositories/local_repository.dart';
import 'package:remax_mapstate/domain/use_cases/get_area_brokers.dart';
import 'package:remax_mapstate/domain/use_cases/get_areas.dart';
import 'package:remax_mapstate/domain/use_cases/get_top_projects.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/check_for_favorite_project.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/delete_fav_project.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/get_fav_projects.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/save_fav_project.dart';

import 'package:remax_mapstate/presentation/bloc/areas_bloc/areas_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/brokers_by_area/area_brokers_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/favorite_projects/favorite_projects_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/project_backdrop/project_backdrop_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/top_projects/top_projects_bloc.dart';
import 'package:remax_mapstate/presentation/cubit/broker_changed/broker_changed_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:remax_mapstate/presentation/cubit/project_scrollable_indicator/indicator_position_cubit.dart';
import 'package:remax_mapstate/router/app_router.dart';
import '../presentation/cubit/current_user/current_user_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  ///********************************** AppRouter *********************************************\\\
  getItInstance.registerFactory<AppRouter>(() => AppRouter());

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

  ///********************************** Repositories *********************************************\\\

  /// Instance of ProjectsApiRepo
  getItInstance.registerLazySingleton<ApiRepo>(
    () => ProjectApiRepoImpl(
      remoteDataSource: getItInstance(),
    ),
  );

  ///********************************** Local_Repositories *********************************************\\\
  /// Instance of LocalRepository
  getItInstance.registerLazySingleton<LocalRepository>(
    () => LocalRepositoryImpl(
      localDataSource: getItInstance(),
    ),
  );

  ///********************************** Remote_Use_Cases *********************************************\\\
  /// GetTopProjects
  getItInstance.registerLazySingleton<GetTopProjects>(
    () => GetTopProjects(projectApiRepo: getItInstance()),
  );

  /// GetAreasCase
  getItInstance.registerLazySingleton<GetAreasCase>(
    () => GetAreasCase(
      projectApiRepo: getItInstance(),
    ),
  );

  /// GetAreasBrokersCase
  getItInstance.registerLazySingleton<GetAreaBrokersCase>(
    () => GetAreaBrokersCase(
      apiRepo: getItInstance(),
    ),
  );

  ///********************************** Local_Use_Cases *********************************************\\\
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
  /// init navigation cubit
  getItInstance.registerFactory<NavigationCubit>(() => NavigationCubit());

  /// init CurrentUserCubit
  getItInstance.registerSingleton<CurrentUserCubit>(
    CurrentUserCubit(),
  );

  /// init BrokerChangeCubit
  getItInstance.registerFactory<BrokerChangedCubit>(
      ()=>BrokerChangedCubit(),
  );

  ///********************************** init blocs *********************************************\\\
  //==> init LanguageBloc
  getItInstance.registerSingleton<LanguageBloc>(
    LanguageBloc(),
  );

  //==> init ProjectBackdropBloc
  getItInstance.registerSingleton<ProjectBackdropBloc>(
    ProjectBackdropBloc(),
  );

  ///==> init TopProjectsBloc
  getItInstance.registerSingleton<TopProjectsBloc>(TopProjectsBloc(
    getTopProjects: getItInstance(),
    backdropBloc: getItInstance(),
  ));

  /// init areas bloc
  getItInstance.registerSingleton<AreasBloc>(
    AreasBloc(
      getAreas: getItInstance(),
    ),
  );

  /// init favoriteProjects bloc
  getItInstance.registerSingleton<FavoriteProjectsBloc>(
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
  getItInstance
      .registerFactory<AreaBrokersBloc>(() => AreaBrokersBloc(getAreaBrokersCase: getItInstance()));
}
