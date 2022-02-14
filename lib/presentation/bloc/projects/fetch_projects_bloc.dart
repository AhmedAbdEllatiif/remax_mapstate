import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/use_cases/get_projects.dart';
import 'package:remax_mapstate/presentation/bloc/project_status_backdrop/project_status_backdrop_bloc.dart';
import '../../../domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

part 'fetch_projects_event.dart';

part 'fetch_projects_state.dart';

class FetchProjectsBloc extends Bloc<FetchProjectsEvent, FetchProjectsState> {

  final GetProjectsCase getProjects;

  FetchProjectsBloc({required this.getProjects,})
      : super(FetchProjectsLoading()) {

    on<FetchProjectsEvent>((event, emit) async {
      if (event is LoadFetchProjectsEvent) {

        final either = await getProjects(NoParams());
        either.fold(
          (appError) {

            emit(ErrorLoadingFetchProjects(appError: appError));
          },
          (projects) {

            // emit TopProjectsLoadedState
            emit(FetchProjectsLoadedState(
                projects: projects, defaultIndex: event.defaultIndex));
          },
        );
      }else{
        print("event is else");
      }
    });
  }
}
