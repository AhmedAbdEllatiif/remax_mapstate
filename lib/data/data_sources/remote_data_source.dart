import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:remax_mapstate/common/classes/handle_operation_exceptions.dart';
import 'package:remax_mapstate/common/classes/register_errors_builder.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/enums/app_language.dart';
import 'package:remax_mapstate/data/api/clients/api_client.dart';
import 'package:remax_mapstate/data/api/clients/auth_client.dart';
import 'package:remax_mapstate/data/api/requests/auth/get_profile.dart';
import 'package:remax_mapstate/data/api/requests/mutations/contact_us.dart';
import 'package:remax_mapstate/data/api/requests/queries/areas/ar_areas.dart';
import 'package:remax_mapstate/data/api/requests/queries/areas/en_areas.dart';
import 'package:remax_mapstate/data/api/requests/queries/get_favorite_projects_ids.dart';
import 'package:remax_mapstate/data/api/requests/queries/get_filter_data/en_get_filter_data.dart';
import 'package:remax_mapstate/data/api/requests/queries/project_status/ar_project_status.dart';
import 'package:remax_mapstate/data/api/requests/queries/project_status/en_project_status.dart';
import 'package:remax_mapstate/data/api/requests/queries/projects.dart';
import 'package:remax_mapstate/data/api/requests/queries/unit_type_names/ar_unit_type_names.dart';
import 'package:remax_mapstate/data/api/requests/queries/unit_type_names/en_unit_type_names.dart';
import 'package:remax_mapstate/data/api/requests/mutations/login.dart';
import 'package:remax_mapstate/data/api/requests/mutations/update_user.dart';
import 'package:remax_mapstate/data/models/area_model.dart';
import 'package:remax_mapstate/data/models/auth/profile/get_profile_request_model.dart';
import 'package:remax_mapstate/data/models/auth/profile/get_profile_response_model.dart';
import 'package:remax_mapstate/data/models/auth/register/register_request_model.dart';
import 'package:remax_mapstate/data/models/auth/register/register_response_model.dart';
import 'package:remax_mapstate/data/models/broker_model.dart';
import 'package:remax_mapstate/data/models/contact_developer.dart';
import 'package:remax_mapstate/data/models/get_filter_data.dart';
import 'package:remax_mapstate/data/models/mutation/login/login_request_model.dart';
import 'package:remax_mapstate/data/models/mutation/login/login_response_model.dart';
import 'package:remax_mapstate/data/models/mutation/update_user.dart';
import 'package:remax_mapstate/data/models/page_info.dart';
import 'package:remax_mapstate/data/models/project_model.dart';
import 'package:remax_mapstate/data/models/project_status.dart';
import 'package:remax_mapstate/data/models/success_model.dart';
import 'package:remax_mapstate/data/models/team_support_model.dart';
import 'package:remax_mapstate/data/models/unit_type_model.dart';
import 'package:remax_mapstate/data/models/user_model.dart';
import 'package:remax_mapstate/data/params/add_or_remove_project_to_fav_params.dart';
import 'package:remax_mapstate/data/params/fetch_areas_params.dart';
import 'package:remax_mapstate/data/params/fetch_broker_params.dart';
import 'package:remax_mapstate/data/params/fetch_favorite_projects_params.dart';
import 'package:remax_mapstate/domain/entities/params/contact_us_request_params.dart';

import '../../common/constants/api_constants.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/entities/params/fetch_buyer_user_params.dart';
import '../api/requests/auth/register.dart';
import '../api/requests/queries/brokers/get_borkers_en.dart';
import '../api/requests/queries/brokers/get_broker_ar.dart';
import '../api/requests/queries/get_filter_data/ar_get_filter_data.dart';
import '../api/requests/queries/projects_by_status/ar_project_by_status.dart';
import '../api/requests/queries/projects_by_status/en_project_by_status.dart';
import '../api/requests/mutations/update_broker.dart';
import '../api/requests/queries/users/get_users_en.dart';
import '../models/filter_model.dart';
import '../models/list_of_fav_project_ids.dart';
import '../models/mutation/contact_us_request_model.dart';
import '../models/mutation/update_broker_request_model.dart';

abstract class RemoteDataSource {
  //===============================>  Auth  <================================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// registerNewUser
  Future<dynamic> registerNewUser(RegisterRequestModel registerRequestModel);

  /// getCurrentUserProfile
  Future<dynamic> getCurrentUserProfile(
      GetProfileRequestModel getProfileRequestModel);

  //============================>  Update User  <=============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// updateCurrentUserGroup
  Future<dynamic> updateUserAfterRegistration(
      UpdateUserMutationModel updateUserMutationModel);

  /// upload user avatar Image
  Future<dynamic> updateUserAvatar(
      UpdateUserMutationModel updateUserMutationModel);

  /// to add or remove favorite project
  Future<dynamic> addOrRemoveFavoriteProject(
      {required UpdateUserMutationModel updateUserMutationModel});

  /// contactUs
  Future<dynamic> contactUs(ContactUsRequestParams contactUsRequestParams);

  /// getFavoriteProjectsIds
  Future<dynamic> getFavoriteProjectsIds(
      FetchFavoriteProjectsParams fetchFavoriteProjectsParams);

  /// return  projects
  Future<List<ProjectModel>> fetchProjects();

  /// return residential projects
  Future<List<ProjectModel>> getResidentialProjects(int areaId);

  /// return commercial projects
  Future<List<ProjectModel>> getCommercialProjects(int areaId);

  /// return areas_by_status
  Future<List<AreaModel>> getAreas(FetchAreaParams params);

  /// return list of brokers
  Future<List<BrokerModel>> getAreaBrokers();

  /// return list project status
  Future<List<ProjectStatusModel>> getProjectStatus({
    required AppLanguage appLanguage,
    required PageInfo pageInfo,
    required List<FilterModel> filtersList,
  });

  /// return list unitTypes status
  Future<List<UnitTypeModel>> getUnitTypesNames({
    required AppLanguage appLanguage,
    required PageInfo pageInfo,
    required List<FilterModel> filtersList,
  });

  /// return list of projects by their status
  Future<List<ProjectModel>> getProjectByStatus({
    required AppLanguage appLanguage,
    required PageInfo pageInfo,
    required List<FilterModel> filtersList,
  });

  /// return filter data model
  Future<FilterDataModel> getFilterDataModel({
    required AppLanguage appLanguage,
  });

  /// return the developer contact data
  Future<ContactDeveloperModel> getDeveloperContact(String developerId);

  /// return team support data
  Future<TeamSupportModel> getTeamSupport();

  /// return list of projects
  Future<List<ProjectModel>> advancedFilterProject({
    required AppLanguage appLanguage,
    required PageInfo pageInfo,
    required List<FilterModel> filtersList,
  });

  Future<dynamic> updateDefaultUser({
    required UpdateUserMutationModel updateUserMutationModel,
  });

  /// login
  Future<dynamic> loginUser({
    required LoginRequestModel loginRequestModel,
  });

  /// getBrokerById
  Future<dynamic> getBrokerById({required FetchBrokerParams params});

  /// getBuyerById
  Future<dynamic> getBuyerById({required FetchBuyerUserParams params});

  /// updateBrokerData
  Future<dynamic> updateBrokerData({
    required UpdateBrokerRequestModel updateBrokerRequestModel,
  });
}

class RemoteDateSourceImpl extends RemoteDataSource {
  final ApiClient apiClient;
  final AuthClient authClient;

  RemoteDateSourceImpl({
    required this.authClient,
    required this.apiClient,
  });

  //===============================>  Auth  <================================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  @override
  Future<dynamic> registerNewUser(
    RegisterRequestModel registerRequestModel,
  ) async {
    try {
      final query = registerNewUserRequest();

      final QueryResult result = await authClient.mutate(
        query,
        token: "", // there is no token with register
        variables: {
          VariablesConstants.email: registerRequestModel.email,
          VariablesConstants.password: registerRequestModel.password,
        },
      );

      log("RemoteDataSource >> registerNewUser >> ${result.data}");
      final responseModel = registerResponseModelFromJson(result.data);

      //==> register not success
      if (!responseModel.success) {
        final registerError =
            RegisterErrorBuilder.fromError(responseModel.errors);

        log("................\nregisterNewUser not success >> "
            "Error: $registerError .................\n");
        return AppError(registerError.appErrorType,
            message: "registerNewUser ${registerError.appErrorType} ");
      }

      return responseModel;
    } catch (e) {
      log("................\nregisterNewUser >> Error: $e .................\n");
      return AppError(AppErrorType.unHandledError,
          message: "registerNewUser UnHandledError >> $e");
    }
  }

  /// login
  @override
  Future<dynamic> loginUser({
    required LoginRequestModel loginRequestModel,
  }) async {
    try {
      final mutation = loginUserMutation();

      final QueryResult result = await authClient.mutate(
        mutation,
        token: "",
        variables: {
          VariablesConstants.email: loginRequestModel.email,
          VariablesConstants.password: loginRequestModel.password,
        },
      );

      log("loginUser >> ResultOnly >> ..........\n \n \n $result.......\n\n\n");
      log("loginUser >> Data >> ..........\n ${result.data}.......");
      if (result.data!["tokenAuth"] != null) {
        final errors = result.data!["tokenAuth"]["errors"];
        if (errors != null) {
          final appErrorType =
              AppErrorTypeBuilder.fromAuthErrors(errors).appErrorType;
          return AppError(appErrorType, message: "Wrong Email or Password");
        }
      }
      return loginResponseModelFromJson(result.data!["tokenAuth"]);
    } catch (e) {
      log("Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "loginUser UnHandledError >> $e");
    }
  }

  /// getCurrentUserProfile
  @override
  Future<dynamic> getCurrentUserProfile(
      GetProfileRequestModel getProfileRequestModel) async {
    try {
      final query = getProfile();

      final QueryResult result = await authClient.get(
        query,
        token: getProfileRequestModel.userToken,
      );
      log("RemoteDataSource >>  result >> ${result.data}");
      return getProfileResponseFromJson(result.data);
    } catch (e) {
      return AppError(AppErrorType.unHandledError,
          message:
              "RemoteDataSource >> getCurrentUserProfile UnHandledError >> $e");
    }
  }

  //============================>  Update User  <=============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  @override
  Future<dynamic> updateUserAfterRegistration(
    UpdateUserMutationModel updateUserMutationModel,
  ) async {
    try {
      final mutationFields = updateUserMutation();

      final QueryResult result = await apiClient.mutate(
        mutationFields,
        variables: {
          VariablesConstants.inputForm: updateUserMutationModel.toJson(),
        },
      );

      log("updateUser >> Data >> ..........\n ${result.data}.......");
      return userModelFormUpdateUser(result.data);
    } catch (e) {
      return AppError(AppErrorType.unHandledError,
          message: "updateDefaultUser UnHandledError >> $e");
    }
  }

  @override
  Future<dynamic> updateUserAvatar(
    UpdateUserMutationModel updateUserMutationModel,
  ) async {
    try {
      log("updateUserAvatar >> start request ");
      final mutationFields = updateUserMutation();

      final QueryResult result = await apiClient.mutate(
        mutationFields,
        variables: {
          VariablesConstants.inputForm: updateUserMutationModel.toJson(),
        },
      );

      log("updateUserAvatar >> Data >> ..........\n ${result.data}.......");
      return userModelFormUpdateUser(result.data);
    } catch (e) {
      log("updateUserAvatar >> Error >> ..........\n $e .......");
      return AppError(AppErrorType.unHandledError,
          message: "updateUserAvatar UnHandledError >> $e");
    }
  }

  /// addOrRemoveFavoriteProject
  @override
  Future<dynamic> addOrRemoveFavoriteProject(
      {required UpdateUserMutationModel updateUserMutationModel}) async {
    try {
      log("addOrRemoveFavoriteProject >> start request ");
      final mutationFields = updateUserMutation();

      final QueryResult result = await apiClient.mutate(
        mutationFields,
        variables: {
          VariablesConstants.inputForm: updateUserMutationModel.toJson(),
        },
      );

      log("addOrRemoveFavoriteProject >> Data >> ..........\n ${result.data}.......");
      return SuccessModel();
    } catch (e) {
      log("addOrRemoveFavoriteProject >> Error >> ..........\n $e .......");
      return AppError(AppErrorType.unHandledError,
          message: "addOrRemoveFavoriteProject UnHandledError >> $e");
    }
  }

  //============================>  contactUs  <===============================\\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //                                                                          \\
  //==========================================================================\\
  /// contactUs
  @override
  Future<dynamic> contactUs(
      ContactUsRequestParams contactUsRequestParams) async {
    try {
      final mutationFields = contactUsMutation();

      final QueryResult result = await apiClient.mutate(
        mutationFields,
        variables: {
          VariablesConstants.inputForm:
              ContactUsRequestModel.fromParams(params: contactUsRequestParams)
                  .toJson(),
        },
      );

      log("contactUs >> Data >> ..........\n ${result.data}.......");
      return SuccessModel();
    } catch (e) {
      log("contactUs >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "contactUs UnHandledError >> $e");
    }
  }

  /// getFavoriteProjectsIds
  @override
  Future<dynamic> getFavoriteProjectsIds(
      FetchFavoriteProjectsParams fetchFavoriteProjectsParams) async {
    log("Start getFavoriteProjectsIds");
    log("Start getFavoriteProjectsIds userId >> ${fetchFavoriteProjectsParams.userId}");
    final mutationFields = getFavoriteProjectIdsQuery();

    final QueryResult result = await apiClient.mutate(
      mutationFields,
      variables: {
        VariablesConstants.pk:
        int.parse(fetchFavoriteProjectsParams.userId),
      },
    );

    //log("getFavoriteProjectsIds >> Data >> ..........\n ${result.data}.......");
    return listOfProjectByIds(result.data);
    try {

    } catch (e) {
      log("getFavoriteProjectsIds >> Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getFavoriteProjectsIds UnHandledError >> $e");
    }
  }

  List<BrokerModel> areaBrokers() {
    return const [
      BrokerModel(
          id: 0,
          age: 33,
          image: AssetsConstants.person1,
          name: "John",
          rating: 3.5,
          totalDoneDeals: 50,
          whatsappNum: '+201154949495',
          phoneNum: '+201154949495'),
      BrokerModel(
          id: 1,
          age: 28,
          image: AssetsConstants.person1,
          name: "Micheal",
          rating: 4.5,
          totalDoneDeals: 180,
          whatsappNum: '+201154949495',
          phoneNum: '+201154949495'),
      BrokerModel(
          id: 2,
          age: 33,
          image: AssetsConstants.person1,
          name: "John",
          rating: 3.5,
          totalDoneDeals: 50,
          whatsappNum: '+201154949495',
          phoneNum: '+201154949495'),
      BrokerModel(
          id: 3,
          age: 28,
          image: AssetsConstants.person1,
          name: "Micheal",
          rating: 4.5,
          totalDoneDeals: 180,
          whatsappNum: '+201154949495',
          phoneNum: '+201154949495'),
      BrokerModel(
          id: 4,
          age: 33,
          image: AssetsConstants.person1,
          name: "John",
          rating: 3.5,
          totalDoneDeals: 50,
          whatsappNum: '+201154949495',
          phoneNum: '+201154949495'),
      BrokerModel(
          id: 5,
          age: 28,
          image: AssetsConstants.person1,
          name: "Micheal",
          rating: 4.5,
          totalDoneDeals: 180,
          whatsappNum: '+201154949495',
          phoneNum: '+201154949495'),
      BrokerModel(
          id: 6,
          age: 33,
          image: AssetsConstants.person1,
          name: "John",
          rating: 3.5,
          totalDoneDeals: 50,
          whatsappNum: '+201154949495',
          phoneNum: '+201154949495'),
      BrokerModel(
          id: 7,
          age: 28,
          image: AssetsConstants.person1,
          name: "Micheal",
          rating: 4.5,
          totalDoneDeals: 180,
          whatsappNum: '+201154949495',
          phoneNum: '+201154949495'),
    ];
  }

  ContactDeveloperModel developerContact() {
    return const ContactDeveloperModel(
      id: 0,
      developerName: "Mountain View",
      empFirstName: "Jack",
      empSecondName: "Alison",
      latitude: 37.759392,
      longitude: -122.5107336,
      image: AssetsConstants.person2,
      empPhoneNum: "+201154949495",
    );
  }

  ContactDeveloperModel developerContactWithOutImage() {
    return const ContactDeveloperModel(
      id: 1,
      developerName: "Mountain View",
      empFirstName: "Jack",
      empSecondName: "Alison",
      latitude: null,
      longitude: null,
      empPhoneNum: "+201154949495",
    );
  }

  TeamSupportModel teamSupportModel() {
    return const TeamSupportModel(
      id: 0,
      firstName: "Haytham",
      lastName: "Hagrasy",
      phoneNum: "+200112*****",
      whatsappNum: '+201154949495',
      image: AssetsConstants.person2,
    );
  }

  @override
  Future<List<AreaModel>> getAreas(FetchAreaParams params) async {

    final query = params.appLanguage == AppLanguage.en
        ? fetchEnglishAreasQuery()
        : fetchArabicAreasQuery();
    final QueryResult result = await apiClient.get(
      query,
      variables: {
        VariablesConstants.limit: params.limit,
        VariablesConstants.offset: params.offset,
        VariablesConstants.orderBy: params.orderBy,
      },
    );
    final areasList = listOfAreasFromJson(result.data!);
    return areasList;
  }

  /// fetch projects
  @override
  Future<List<ProjectModel>> fetchProjects() async {
    final QueryResult result = await apiClient.get(fetchProjectsQuery());
    return listOfProjectModel(result.data!);
  }

  @override
  Future<List<BrokerModel>> getAreaBrokers() async {
    final brokers = await areaBrokers();
    return brokers;
  }

  @override
  Future<List<ProjectModel>> getCommercialProjects(int areaId) async {
    //final myProjects = await projects();
    final List<ProjectModel> myProjects = [];
    return myProjects;
  }

  @override
  Future<List<ProjectModel>> getResidentialProjects(int areaId) async {
    //final myProjects = await projects();
    return [];
  }

  /// return list project status
  @override
  Future<List<ProjectStatusModel>> getProjectStatus({
    required AppLanguage appLanguage,
    required PageInfo pageInfo,
    required List<FilterModel> filtersList,
  }) async {
    final query = appLanguage == AppLanguage.en
        ? fetchEnglishProjectStatusQuery()
        : fetchArabicProjectStatusQuery();

    final QueryResult result = await apiClient.get(
      query,
      variables: {
        VariablesConstants.pageInfo: pageInfo.toJson(),
        VariablesConstants.filters: listOfFilterToJson(filtersList),
      },
    );

    //log("UnitTypeNames >> Data >> ..........\n ${result.data}.......");
    return listOfProjectStatusFromJson(result.data!);
    //return [];
  }

  /// return list unitTypes status
  @override
  Future<List<UnitTypeModel>> getUnitTypesNames({
    required AppLanguage appLanguage,
    required PageInfo pageInfo,
    required List<FilterModel> filtersList,
  }) async {
    final query = appLanguage == AppLanguage.en
        ? fetchEnglishUnitTypeNamesQuery()
        : fetchArabicUnitTypeNamesQuery();

    final QueryResult result = await apiClient.get(
      query,
      variables: {
        VariablesConstants.pageInfo: pageInfo.toJson(),
        VariablesConstants.filters: listOfFilterToJson(filtersList),
      },
    );

    //log("UnitTypeNames >> Data >> ..........\n ${result.data}.......");
    return listOfUnitTypeNamesFromJson(result.data!);
  }

  /// projects by their status
  @override
  Future<List<ProjectModel>> getProjectByStatus(
      {required AppLanguage appLanguage,
      required PageInfo pageInfo,
      required List<FilterModel> filtersList}) async {
    final query = appLanguage == AppLanguage.en
        ? fetchEnglishProjectByStatusQuery()
        : fetchArabicProjectByStatusQuery();

    final QueryResult result = await apiClient.get(
      query,
      variables: {
        VariablesConstants.pageInfo: pageInfo.toJson(),
        VariablesConstants.filters: listOfFilterToJson(filtersList),
      },
    );

    //log("getProjectByStatus >> Data >> ..........\n ${result.data}.......");
    return listOfProjectModel(result.data!);
  }

  /// return the developer contact data
  @override
  Future<ContactDeveloperModel> getDeveloperContact(String developerId) async {
    final developerContactData = int.parse(developerId) % 2 == 0
        ? await developerContact()
        : await developerContactWithOutImage();
    return developerContactData;
  }

  @override
  Future<TeamSupportModel> getTeamSupport() async {
    final teamSupport = await teamSupportModel();
    return teamSupport;
  }

  @override
  Future<FilterDataModel> getFilterDataModel({
    required AppLanguage appLanguage,
  }) async {
    final query = appLanguage == AppLanguage.en
        ? fetchEnFilterDataQuery()
        : fetchArFilterDataQuery();

    final QueryResult result = await apiClient.get(
      query,
      // variables: {
      //   VariablesConstants.pageInfo: pageInfo.toJson(),
      //   VariablesConstants.filters: listOfFilterToJson(filtersList),
      // },
    );

    //log("getProjectByStatus >> Data >> ..........\n ${result.data}.......");
    //log("getProjectByStatus >> Data String >> ..........\n ${filterDataModelFromJson(result.data!)}.......");
    return filterDataModelFromJson(result.data!);
  }

  /// advancedFilterProject
  @override
  Future<List<ProjectModel>> advancedFilterProject(
      {required AppLanguage appLanguage,
      required PageInfo pageInfo,
      required List<FilterModel> filtersList}) async {
    final query = appLanguage == AppLanguage.en
        ? fetchEnglishProjectByStatusQuery()
        : fetchArabicProjectByStatusQuery();

    final QueryResult result = await apiClient.get(
      query,
      variables: {
        VariablesConstants.pageInfo: pageInfo.toJson(),
        VariablesConstants.filters: listOfFilterToJson(filtersList),
      },
    );

    //log("getProjectByStatus >> Data >> ..........\n ${result.data}.......");
    return listOfProjectModel(result.data!);
  }

  /// updateUser
  @override
  Future<dynamic> updateDefaultUser({
    required UpdateUserMutationModel updateUserMutationModel,
  }) async {
    try {
      final mutationFields = updateUserMutation();

      final QueryResult result = await apiClient.mutate(
        mutationFields,
        variables: {
          VariablesConstants.inputForm: updateUserMutationModel.toJson(),
        },
      );

      log("updateUser >> ResultOnly >> ..........\n \n \n ${result}.......\n\n\n");
      log("updateUser >> Data >> ..........\n ${result.data}.......");
      return userModelFormUser(result.data!["updateUser"]);
    } catch (e) {
      return AppError(AppErrorType.unHandledError,
          message: "updateDefaultUser UnHandledError >> $e");
    }
  }

  @override
  Future<dynamic> getBuyerById({required FetchBuyerUserParams params}) async {
    try {
      final query = getBuyerUsersEnglishQuery();

      final QueryResult result = await apiClient.get(
        query,
        variables: {
          VariablesConstants.pk: params.buyerId,
        },
      );

      log("getBuyerById >> Data >> ..........\n ${result.data}.......");
      return listUserModelFormUsers(result.data);
    } catch (e) {
      log("Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getBuyerById UnHandledError >> $e");
    }
  }

  /// getBrokerById
  @override
  Future<dynamic> getBrokerById({required FetchBrokerParams params}) async {
    try {
      final query = params.appLanguage == AppLanguage.en
          ? getBrokersEnglishQuery()
          : getBrokersArabicQuery();

      final QueryResult result = await apiClient.get(
        query,
        variables: {
          VariablesConstants.pk: params.brokerId,
        },
      );

      log("getBrokerById >> Data >> ..........\n ${result.data}.......");
      return listUserModelFormBroker(result.data);
    } catch (e) {
      log("Error: $e");
      return AppError(AppErrorType.unHandledError,
          message: "getBrokerById UnHandledError >> $e");
    }
  }

  /// updateUser
  @override
  Future<dynamic> updateBrokerData({
    required UpdateBrokerRequestModel updateBrokerRequestModel,
  }) async {
    try {
      final mutationFields = updateBrokerMutation();

      final QueryResult result = await apiClient.mutate(
        mutationFields,
        variables: {
          VariablesConstants.inputForm: updateBrokerRequestModel.toJson(),
        },
      );

      log("updateUser >> ResultOnly >> ..........\n \n \n ${result}.......\n\n\n");
      log("updateUser >> Data >> ..........\n ${result.data}.......");
      return SuccessModel();
    } catch (e) {
      return AppError(AppErrorType.unHandledError,
          message: "updateDefaultUser UnHandledError >> $e");
    }
  }
}
