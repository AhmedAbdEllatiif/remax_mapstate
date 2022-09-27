import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/data/models/filter_model.dart';
import 'package:remax_mapstate/data/models/page_info.dart';
import 'package:remax_mapstate/data/params/fetch_list_params.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_project_status.dart';

import '../../../../common/enums/app_language.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/use_cases/get_projects_by_status.dart';
import '../language/language_cubit.dart';

part 'projects_by_status_state.dart';

class ProjectsByStatusCubit extends Cubit<ProjectsByStatusState> {
  ProjectsByStatusCubit() : super(ProjectsByStatusInitial());

  void fetchProjectByStatus(
    BuildContext context, {
    required String statusId,
    required int limit,
    required currentListLength,
  }) async {

      // emit loading
    if(currentListLength == 0){
      _emitIfNotClosed(LoadingProjectsByStatus());
    }else{
      _emitIfNotClosed(LoadingMoreProjectsByStatus());
    }


    // init current language
    final languageCode = context.read<LanguageCubit>().state.languageCode;
    final appLanguage = languageCode == "en" ? AppLanguage.en : AppLanguage.ar;

    // init next offset
    final nextOffset = currentListLength == 0 ? 0 : currentListLength + 1;

    // init page info
    final pageInfo = PageInfo(limit: limit, offset: nextOffset, orderBy: "id");

    // init filters
    final statusIdFilter = FilterModel(field: "status__id", value: statusId);

    // init params
    final params = FetchListParams(
      appLanguage: appLanguage,
      pageInfo: pageInfo,
      filters: [statusIdFilter],
    );

    // init useCase
    final getProjectsByStatusCase = getItInstance<GetProjectsByStatusCase>();

    // send fetch request
    final either = await getProjectsByStatusCase(params);

    either.fold(
        //==> error occurred
        (appError) => _emitIfNotClosed(_errorToEmit(
              appError: appError,
              offset: nextOffset,
            )),

        //==> projects fetched
        (projectsList) => _emitIfNotClosed(
              _statusToEmit(projectsList: projectsList, limit: limit),
            ));
  }

  /// to return an error state
  /// * param [offset] is the current offset to fetch
  /// * if the current offset is zero this means error occurred
  /// while while fetching first page
  /// * if not zero this means error occurred while fetching more projects
  ProjectsByStatusState _errorToEmit(
      {required AppError appError, required int offset}) {
    if (offset == 0) {
      return ErrorWhileLoadingProjectsByStatus(appError: appError);
    } else {
      return ErrorWhileLoadingMoreProjectsByStatus(appError: appError);
    }
  }

  /// to emit the result of success fetching the required projects
  /// * param [limit] is the current limit to fetch
  /// * if the length of fetched projects is less than the sent limit,
  /// this means last page reached
  ProjectsByStatusState _statusToEmit(
      {required List<ProjectEntity> projectsList, required int limit}) {
    //==> empty list
    if (projectsList.isEmpty) {
      return EmptyProjectsByStatus();
    }
    //==> last page reached
    else if (projectsList.length < limit) {
      return LastPageProjectsByStatusReached(projects: projectsList);
    }
    //==> projects fetched
    else {
      return ProjectsByStatusFetched(projects: projectsList);
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(ProjectsByStatusState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
