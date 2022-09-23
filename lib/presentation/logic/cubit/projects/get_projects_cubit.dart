import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/use_cases/get_projects.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

part 'get_projects_state.dart';

class GetProjectsCubit extends Cubit<GetProjectsState> {
  final GetProjectsCase getProjects;

  GetProjectsCubit({
    required this.getProjects,
  }) : super(LoadingProjects());

  /// fetch projects
  void fetchProjects() async {
    // init GetProjectsCase
    final GetProjectsCase getProjects = getItInstance<GetProjectsCase>();

    // fetch projects
    final either = await getProjects(NoParams());

    either.fold(
      (appError) {
        _emitIfNotClosed(ErrorLoadingFetchProjects(appError: appError));
      },
      (projects) {
        // emit TopProjectsLoadedState
        _emitIfNotClosed(ProjectsFetched(
          projects: projects,
        ));
      },
    );
  }

  /// emit if not closed
  void _emitIfNotClosed(GetProjectsState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
