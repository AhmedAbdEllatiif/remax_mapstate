import 'package:get_it/get_it.dart';
import 'package:remax_mapstate/data/data_sources/remote_data_source.dart';
import 'package:remax_mapstate/data/repositories/project_api_repo_impl.dart';
import 'package:remax_mapstate/domain/repositories/api_projects.dart';
import 'package:remax_mapstate/domain/use_cases/get_areas.dart';
import 'package:remax_mapstate/domain/use_cases/get_top_projects.dart';
import 'package:remax_mapstate/presentation/bloc/areas_bloc/areas_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/project_backdrop/project_backdrop_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/top_projects/top_projects_bloc.dart';
import 'package:remax_mapstate/presentation/cubit/navigation/navigation_cubit.dart';
import '../presentation/cubit/current_user/current_user_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  /// Instance of RemoteDataSource
  getItInstance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDateSourceImpl(),
  );

  /// Instance of ProjectsApiRepo
  getItInstance.registerLazySingleton<ProjectApiRepo>(
    () => ProjectApiRepoImpl(
      remoteDataSource: getItInstance(),
    ),
  );

  ///********************************** Use_Cases *********************************************\\\
  //==> GetTopProjects
  getItInstance.registerLazySingleton<GetTopProjects>(
    () => GetTopProjects(projectApiRepo: getItInstance()),
  );

  /// GetAreasCase
  getItInstance.registerLazySingleton<GetAreasCase>(
    () => GetAreasCase(
      projectApiRepo: getItInstance(),
    ),
  );

  ///********************************** init cubit *********************************************\\\
  //==> init navigation cubit
  getItInstance.registerFactory<NavigationCubit>(() => NavigationCubit());

  //==> init CurrentUserCubit
  getItInstance.registerSingleton<CurrentUserCubit>(
    CurrentUserCubit(),
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
}
