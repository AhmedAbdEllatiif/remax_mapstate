import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/data/params/fetch_fav_projects_params.dart';
import 'package:remax_mapstate/domain/use_cases/fav_projects/get_fav_projects_case.dart';

import '../../../../common/enums/app_language.dart';
import '../../../../data/models/page_info.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/app_error.dart';
import '../../../../domain/entities/project_entity.dart';
import '../language/language_cubit.dart';

part 'get_fav_projects_state.dart';

class GetFavProjectsCubit extends Cubit<GetFavProjectsState> {
  GetFavProjectsCubit() : super(FavProjectsInitial());

  void fetchFavProjects(
    BuildContext context, {
    required String userToken,
    required String userId,
    required int limit,
    required currentListLength,
  }) async {
    // emit loading
    if (currentListLength == 0) {
      _emitIfNotClosed(LoadingFavProjects());
    } else {
      _emitIfNotClosed(LoadingMoreFavProjects());
    }

    // init current language
    final languageCode = context.read<LanguageCubit>().state.languageCode;
    final appLanguage = languageCode == "en" ? AppLanguage.en : AppLanguage.ar;

    // init next offset
    final nextOffset = currentListLength == 0 ? 0 : currentListLength + 1;

    // init page info
    final pageInfo = PageInfo(limit: limit, offset: nextOffset, orderBy: "id");

    // init params
    final params = FetchFavProjectsParams(
      appLanguage: appLanguage,
      limit: pageInfo.limit,
      offset: pageInfo.offset,
      userId: userId,
      userToken: userToken,
    );

    // init useCase
    final getFavProjectsCase = getItInstance<GetFavProjectsCase>();

    // send fetch request
    final either = await getFavProjectsCase(params);

    either.fold(
        //==> error occurred
        (appError) => _emitIfNotClosed(_errorToEmit(
              appError: appError,
              offset: nextOffset,
            )),

        //==> projects fetched
        (projectsList) => _emitIfNotClosed(
              _statusToEmit(
                  projectsList: projectsList,
                  limit: limit,
                  currentListSize: currentListLength),
            ));
  }

  /// to return an error state
  /// * param [offset] is the current offset to fetch
  /// * if the current offset is zero this means error occurred
  /// while while fetching first page
  /// * if not zero this means error occurred while fetching more projects
  GetFavProjectsState _errorToEmit(
      {required AppError appError, required int offset}) {
    if (offset == 0) {
      return ErrorWhileLoadingFavProjects(appError: appError);
    } else {
      return ErrorWhileLoadingMoreFavProjects(appError: appError);
    }
  }

  /// to emit the result of success fetching the required projects
  /// * param [limit] is the current limit to fetch
  /// * if the length of fetched projects is less than the sent limit,
  /// this means last page reached
  GetFavProjectsState _statusToEmit(
      {required List<ProjectEntity> projectsList,
      required int limit,
      required int currentListSize}) {
    if (projectsList.isEmpty && currentListSize > 0) {
      return LastPageFavProjectsReached(projects: projectsList);
    }

    //==> empty list
    else if (projectsList.isEmpty) {
      return EmptyFavProjects();
    }

    //==> last page reached
    else if (projectsList.length < limit) {
      return LastPageFavProjectsReached(projects: projectsList);
    }

    //==> projects fetched
    else {
      return FavProjectsFetched(projects: projectsList);
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(GetFavProjectsState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
