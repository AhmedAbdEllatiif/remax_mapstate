import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/data/params/fetch_favorite_projects_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/use_cases/fav_projects/get_fav_projects_ids_case.dart';

import '../../../../di/git_it.dart';

part 'check_current_favorite_project_state.dart';

class CheckCurrentFavoriteProjectCubit
    extends Cubit<CheckCurrentFavoriteProjectState> {
  CheckCurrentFavoriteProjectCubit()
      : super(CheckCurrentFavoriteProjectInitial());

  void checkCurrentProjectIsFavorite({
    required String userToken,
    required String userId,
    required String projectId,
  }) async {
    _emitIfNotClosed(LoadingCheckFavoriteProject());

    // init params
    final params = FetchFavoriteProjectsParams(
      userId: userId,
      userToken: userToken,
    );

    // init useCase
    final useCase = getItInstance<GetFavProjectsIdsCase>();

    // fetch unit type names
    final either = await useCase(params);

    either.fold(
      //==> error
      (appError) => _emitError(appError),

      //==> success
      (ids) {
        final isFavorite = ids.contains(int.parse(projectId));
        _emitIfNotClosed(
            CurrentProjectFavOrNotResult(isFavoriteProject: isFavorite));
      },
    );
  }

  /// _emit an error according to AppError
  void _emitError(AppError appError) {
    if (appError.appErrorType == AppErrorType.unAuthorized) {
      _emitIfNotClosed(UnAuthorizedToCheckFavoriteProject());
    } else {
      _emitIfNotClosed(ErrorWhileGettingFavProjectIds(appError: appError));
    }
  }

  /// emit if not closed
  void _emitIfNotClosed(CheckCurrentFavoriteProjectState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
