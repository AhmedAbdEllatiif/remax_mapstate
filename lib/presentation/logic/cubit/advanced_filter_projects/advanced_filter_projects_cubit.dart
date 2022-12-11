import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/data/models/filter_model.dart';

import '../../../../common/enums/app_language.dart';
import '../../../../data/models/page_info.dart';
import '../../../../data/params/fetch_list_params.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/project_entity.dart';
import '../../../../domain/use_cases/advanced_filter_projects.dart';
import '../advanced_filter_builder/advanced_filter_builder_cubit.dart';
import '../language/language_cubit.dart';

part 'advanced_filter_projects_state.dart';

class AdvancedFilterProjectsCubit extends Cubit<AdvancedFilterProjectsState> {
  final AdvancedFilterBuilderCubit advancedFilterBuilderCubit;

  AdvancedFilterProjectsCubit({required this.advancedFilterBuilderCubit})
      : super(AdvancedFilterProjectsInitial());

  void searchProjects(
    BuildContext context, {
    required List<FilterModel> filters,
    required int limit,
    required currentListLength,
  }) async {
    // emit loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingAdvancedFilterProjects());
    } else {
      _emitIfNotClosed(LoadingMoreAdvancedFilterProjects());
    }

    // init current language
    final languageCode = context.read<LanguageCubit>().state.languageCode;
    final appLanguage = languageCode == "en" ? AppLanguage.en : AppLanguage.ar;

    // init next offset
    final nextOffset = currentListLength == 0 ? 0 : currentListLength + 1;

    // init page info
    final pageInfo =
        PageInfo(limit: limit, offset: nextOffset, orderBy: "price_from");

    //log("Filter To send >> ${advancedFilterBuilderCubit.state.filters}");
    // init params
    final params = FetchListParams(
      appLanguage: appLanguage,
      pageInfo: pageInfo,
      filters: filters,
    );

    // init useCase
    final getAdvancedFilterProjectsCase =
        getItInstance<AdvancedFilterProjectsCase>();

    // send fetch request
    final either = await getAdvancedFilterProjectsCase(params);

    either.fold(
        //==> error occurred
        (appError) => _emitIfNotClosed(_errorToEmit(
              appError: appError,
              offset: nextOffset,
            )),

        //==> projects fetched
        (projectsList) => {
              _emitIfNotClosed(
                _statusToEmit(
                  projectsList: projectsList,
                  limit: limit,
                  currentListSize: currentListLength,
                ),
              ),
              log("ProjectsCount >>>> ${projectsList.length}")
            });
  }

  /// to return an error state
  /// * param [offset] is the current offset to fetch
  /// * if the current offset is zero this means error occurred
  /// while while fetching first page
  /// * if not zero this means error occurred while fetching more projects
  AdvancedFilterProjectsState _errorToEmit(
      {required AppError appError, required int offset}) {
    if (appError.appErrorType == AppErrorType.unAuthorized) {
      return UnAuthorizedFilterProjects();
    }

    if (offset == 0) {
      return ErrorWhileLoadingAdvancedFilterProjects(appError: appError);
    } else {
      return ErrorWhileLoadingMoreAdvancedFilterProjects(appError: appError);
    }
  }

  /// to emit the result of success fetching the required projects
  /// * param [limit] is the current limit to fetch
  /// * if the length of fetched projects is less than the sent limit,
  /// this means last page reached
  AdvancedFilterProjectsState _statusToEmit({
    required List<ProjectEntity> projectsList,
    required int limit,
    required int currentListSize,
  }) {
    if (projectsList.isEmpty && currentListSize > 0) {
      return LastPageAdvancedFilterProjectsReached(projects: projectsList);
    }

    //==> last page reached
    else if (projectsList.length < limit) {
      return LastPageAdvancedFilterProjectsReached(projects: projectsList);
    }

    //==> empty list
    else if (projectsList.isEmpty) {
      return EmptyAdvancedFilterProjects();
    }
    //==> projects fetched
    else {
      return AdvancedFilterProjectsFetched(projects: projectsList);
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(AdvancedFilterProjectsState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
