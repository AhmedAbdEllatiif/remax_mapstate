import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:remax_mapstate/data/api/clients/api_client.dart';
import 'package:remax_mapstate/data/data_sources/app_settings_local_data_source.dart';
import 'package:remax_mapstate/data/data_sources/local_data_source.dart';
import 'package:remax_mapstate/data/data_sources/remote_data_source.dart';
import 'package:remax_mapstate/data/repositories/app_settings_repository_impl.dart';
import 'package:remax_mapstate/data/repositories/loca_repository_impl.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/repositories/app_repository.dart';
import 'package:remax_mapstate/domain/repositories/app_settings_repository.dart';
import 'package:remax_mapstate/domain/repositories/local_repository.dart';
import 'package:remax_mapstate/domain/use_cases/get_area_brokers.dart';
import 'package:remax_mapstate/domain/use_cases/get_areas.dart';
import 'package:remax_mapstate/domain/use_cases/get_commercial_projects.dart';
import 'package:remax_mapstate/domain/use_cases/get_developer_contact.dart';
import 'package:remax_mapstate/domain/use_cases/get_team_support.dart';
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

import 'package:remax_mapstate/presentation/journeys/calculator/formz/downpayment.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/formz/number_of_years.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/formz/unit_price.dart';
import 'package:remax_mapstate/presentation/logic/cubit/advanced_filter_projects/advanced_filter_projects_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/get_filter_data/get_filter_data_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/projects_by_status/projects_by_status_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/unitType_names/unit_type_names_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/api/clients/graphql_client.dart';
import '../data/repositories/remote_repository_impl.dart';
import '../domain/use_cases/advanced_filter_projects.dart';
import '../domain/use_cases/get_filter_data.dart';
import '../domain/use_cases/get_projects_by_status.dart';
import '../domain/use_cases/local_usecases/auto_login/delete_auto_login.dart';
import '../domain/use_cases/local_usecases/auto_login/get_auto_login.dart';
import '../domain/use_cases/local_usecases/auto_login/save_auto_login.dart';
import '../domain/use_cases/make_phone_call.dart';
import '../domain/use_cases/open_map.dart';
import '../domain/use_cases/open_whats_app.dart';
import '../presentation/logic/cubit/areas/areas_cubit.dart';
import '../presentation/logic/cubit/brokers_by_area/get_area_brokers_cubit.dart';
import '../presentation/logic/bloc/calculator_validation/calculator_validation_bloc.dart';
import '../presentation/logic/bloc/project_status/project_status_bloc.dart';
import '../presentation/logic/bloc/project_status_backdrop/project_status_backdrop_bloc.dart';
import '../presentation/logic/cubit/projects/get_projects_cubit.dart';
import '../presentation/logic/cubit/auto_login/auto_login_cubit.dart';
import '../presentation/logic/cubit/broker_changed/broker_changed_cubit.dart';
import '../presentation/logic/cubit/change_login_view/change_login_view_cubit.dart';
import '../presentation/logic/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import '../presentation/logic/cubit/commercial_projects/commercial_projects_cubit.dart';
import '../presentation/logic/cubit/count_down_cubit/count_down_cubit.dart';
import '../presentation/logic/cubit/current_user/current_user_cubit.dart';
import '../presentation/logic/cubit/developer_contact/developer_contact_cubit.dart';
import '../presentation/logic/cubit/language/language_cubit.dart';
import '../presentation/logic/cubit/navigation/navigation_cubit.dart';
import '../presentation/logic/cubit/search_filter_builder/search_filter_builder_cubit.dart';
import '../presentation/logic/cubit/unitType_names/unit_type_names_cubit.dart';
import '../presentation/logic/cubit/team_support/team_support_cubit.dart';
import '../presentation/journeys/calculator/formz/first_down_payment.dart';
import '../presentation/journeys/calculator/formz/second_down_payment.dart';
import '../presentation/journeys/calculator/formz/third_down_payment.dart';
import '../presentation/logic/bloc/favorite_projects/favorite_projects_bloc.dart';
import '../presentation/logic/cubit/project_scrollable_indicator/indicator_position_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {


  ///********************** init Notification channel ***********************\\\
  /// Default android notification channel
  getItInstance.registerFactory<AndroidNotificationChannel>(
          () => const AndroidNotificationChannel(
        'default_channel', // id
        'Default Notifications', // title
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      ));


  ///********************************** init ApiClient *********************************************\\\

  /// GraphQLClient
  getItInstance.registerFactory<GraphQLClient>(() => initApi());

  /// ApiClient
  getItInstance.registerFactory<ApiClient>(
    () => ApiClient(
      graphQLClient: getItInstance(),
    ),
  );

  ///********************************** SharedPreferences *********************************************\\\
  getItInstance.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );

  ///********************************** DataSource *********************************************\\\
  /// Instance of RemoteDataSource
  getItInstance.registerFactory<RemoteDataSource>(
    () => RemoteDateSourceImpl(apiClient: getItInstance()),
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
  getItInstance.registerFactory<RemoteRepository>(
    () => RemoteRepositoryImpl(
      remoteDataSource: getItInstance(),
    ),
  );

  /// Instance of ProjectsApiRepo
  getItInstance.registerLazySingleton<AppRepository>(
    () => AppRepository(),
  );

  ///********************************** Local_Repositories *********************************************\\\
  /// Instance of LocalRepository
  getItInstance.registerLazySingleton<LocalRepository>(
    () => LocalRepositoryImpl(
      localDataSource: getItInstance(),
    ),
  );

  /// Instance of AppSettingsRepository
  getItInstance.registerLazySingleton<AppSettingsRepository>(
    () => AppSettingsRepositoryImpl(
      appSettingsLocalDataSource: getItInstance(),
    ),
  );

  ///********************************** Remote_Use_Cases *********************************************\\\
  /// GetDeveloperContactCase
  getItInstance.registerFactory<GetDeveloperContactCase>(
    () => GetDeveloperContactCase(
      apiRepo: getItInstance(),
    ),
  );

  /// GetAutoLogin
  getItInstance.registerLazySingleton<GetAutoLogin>(() => GetAutoLogin(
        appSettingsRepository: getItInstance(),
      ));

  /// SaveAutoLogin
  getItInstance.registerLazySingleton<SaveAutoLogin>(() => SaveAutoLogin(
        appSettingsRepository: getItInstance(),
      ));

  /// DeleteAutoLogin
  getItInstance.registerLazySingleton<DeleteAutoLogin>(() => DeleteAutoLogin(
        appSettingsRepository: getItInstance(),
      ));

  /// GetTopProjects
  getItInstance.registerLazySingleton<GetProjectsCase>(
    () => GetProjectsCase(projectApiRepo: getItInstance()),
  );

  /// GetAreasCase
  getItInstance.registerFactory<GetAreasCase>(
    () => GetAreasCase(
      projectApiRepo: getItInstance(),
    ),
  );

  /// GetProjectStatusCase
  getItInstance.registerFactory<GetProjectStatusCase>(
    () => GetProjectStatusCase(
      apiRepo: getItInstance(),
    ),
  );

  /// GetProjectStatusCase
  getItInstance.registerFactory<GetFilterDataCase>(
    () => GetFilterDataCase(
      apiRepo: getItInstance(),
    ),
  );

  /// GetProjectsByStatusCase
  getItInstance.registerFactory<GetProjectsByStatusCase>(
    () => GetProjectsByStatusCase(
      apiRepo: getItInstance(),
    ),
  );

  /// GetAreasBrokersCase
  getItInstance.registerLazySingleton<GetAreaBrokersCase>(
    () => GetAreaBrokersCase(
      apiRepo: getItInstance(),
    ),
  );

  /// GetResidentialProjectsCase
  getItInstance.registerLazySingleton<GetResidentialProjectsCase>(
    () => GetResidentialProjectsCase(
      apiRepo: getItInstance(),
    ),
  );

  /// GetCommercialProjectsCase
  getItInstance.registerLazySingleton<GetCommercialProjectsCase>(
    () => GetCommercialProjectsCase(
      apiRepo: getItInstance(),
    ),
  );

  /// GetProjectStatusCase
  getItInstance.registerLazySingleton<GetUnitTypeNamesCase>(
    () => GetUnitTypeNamesCase(
      apiRepo: getItInstance(),
    ),
  );

  /// OpenWhatsappCase
  getItInstance.registerLazySingleton<OpenWhatsappCase>(
    () => OpenWhatsappCase(
      appRepository: getItInstance(),
    ),
  );

  /// OpenMapCase
  getItInstance.registerLazySingleton<OpenMapCase>(
    () => OpenMapCase(
      appRepository: getItInstance(),
    ),
  );

  /// MakePhoneCallCase
  getItInstance.registerLazySingleton<MakePhoneCallCase>(
    () => MakePhoneCallCase(
      appRepository: getItInstance(),
    ),
  );

  /// GetTeamSupportCase
  getItInstance.registerLazySingleton<GetTeamSupportCase>(
    () => GetTeamSupportCase(
      apiRepo: getItInstance(),
    ),
  );

  /// GetTeamSupportCase
  getItInstance.registerFactory<AdvancedFilterProjectsCase>(
    () => AdvancedFilterProjectsCase(
      apiRepo: getItInstance(),
    ),
  );

  ///************************** Local_Use_Cases *****************************\\\

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

  ///*************************** init cubit *********************************\\\

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
    () => BrokerChangedCubit(
      openWhatsappCase: getItInstance(),
      makePhoneCallCase: getItInstance(),
    ),
  );

  /// init ResidentialProjectsCubit
  getItInstance.registerFactory<UnitTypeNamesCubit>(
    () => UnitTypeNamesCubit(
      residentialProjectsCase: getItInstance(),
      getUnitTypesByAreaCase: getItInstance(),
    ),
  );

  /// init CommercialProjectsCubit
  getItInstance.registerFactory<CommercialProjectsCubit>(
    () => CommercialProjectsCubit(
      commercialProjectsCase: getItInstance(),
    ),
  );

  /// init GetFilterDataCubit
  getItInstance.registerFactory<GetFilterDataCubit>(
    () => GetFilterDataCubit(),
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

  /// init DeveloperContactCubit
  getItInstance.registerFactory<DeveloperContactCubit>(
    () => DeveloperContactCubit(
      getDeveloperContactCase: getItInstance(),
      makePhoneCallCase: getItInstance(),
      openMapCase: getItInstance(),
      openWhatsappCase: getItInstance(),
    ),
  );

  /// init TeamSupportCubit
  getItInstance.registerSingleton<TeamSupportCubit>(
    TeamSupportCubit(
      openWhatsappCase: getItInstance(),
      makePhoneCallCase: getItInstance(),
      getTeamSupportCase: getItInstance(),
    ),
  );

  /// ChooseFavoriteAreaCubit
  getItInstance.registerFactory<ChooseFavoriteAreaCubit>(
    () => ChooseFavoriteAreaCubit(),
  );

  /// ProjectsByStatusCubit
  getItInstance.registerFactory<ProjectsByStatusCubit>(
    () => ProjectsByStatusCubit(),
  );

  /// init AdvancedFilterBuilderCubit
  getItInstance.registerFactory<SearchFilterBuilderCubit>(
    () => SearchFilterBuilderCubit(),
  );

  /// init AdvancedFilterProjectsCubit
  getItInstance.registerFactory(
    () =>
        AdvancedFilterProjectsCubit(searchFilterBuilderCubit: getItInstance()),
  );

  ///**************************** init blocs *******************************\\\

  ///==> init ProjectBackdropBloc
  getItInstance.registerFactory<ProjectStatusBackdropBloc>(
    () => ProjectStatusBackdropBloc(),
  );

  ///==> init ProjectStatusBloc
  getItInstance.registerFactory<ProjectStatusBloc>(
    () => ProjectStatusBloc(
      backdropBloc: getItInstance(),
      getProjectStatusCase: getItInstance(),
    ),
  );

  ///==> init FetchProjectsBloc
  getItInstance.registerFactory<GetProjectsCubit>(() => GetProjectsCubit(
        getProjects: getItInstance(),
      ));

  /// init areas_by_status bloc
  getItInstance.registerFactory<AreasCubit>(
    () => AreasCubit(
      getAreas: getItInstance(),
    ),
  );

  /// init favoriteProjects bloc
  getItInstance.registerFactory<FavoriteProjectsBloc>(
    () => FavoriteProjectsBloc(
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
      .registerFactory<GetAreaBrokersCubit>(() => GetAreaBrokersCubit());

  /// init CalculatorValidationBloc
  getItInstance
      .registerFactory<CalculatorValidationBloc>(() => CalculatorValidationBloc(
            unitPrice: const UnitPrice.dirty(value: ''),
            downPayment: const DownPaymentForm.dirty(value: ''),
            numberOfYears: const NumberOfYears.dirty(value: ''),
            firstDownPaymentForm: const FirstDownPaymentForm.dirty(value: ''),
            secondDownPaymentForm: const SecondDownPaymentForm.dirty(value: ''),
            thirdDownPaymentForm: const ThirdDownPaymentForm.dirty(value: ''),
          ));
}
