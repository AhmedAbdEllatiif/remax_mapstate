import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/no_params.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_top_projects.dart';
import 'package:remax_mapstate/presentation/bloc/project_backdrop/project_backdrop_bloc.dart';

part 'top_projects_event.dart';

part 'top_projects_state.dart';

class TopProjectsBloc extends Bloc<TopProjectsEvent, TopProjectsState> {
  final ProjectBackdropBloc backdropBloc;
  final GetTopProjects getTopProjects;

  TopProjectsBloc({required this.getTopProjects, required this.backdropBloc})
      : super(TopProjectsLoading()) {
    print("Start Bloc");
    on<TopProjectsEvent>((event, emit) async {
      if (event is LoadTopProjectsEvent) {
        print("event is LoadTopProjectsEvent");
        final either = await getTopProjects(NoParams());
        either.fold(
          (appError) {
            print("emit appError");
            emit(ErrorLoadingTopProjects(appError: appError));
          },
          (projects) {
            // add BackdropChangedEvent
            backdropBloc.add(ProjectBackdropChangedEvent(
                projectEntity: projects[event.defaultIndex]));
            print("emit TopProjectsLoadedState");
            // emit TopProjectsLoadedState
            emit(TopProjectsLoadedState(
                projects: projects, defaultIndex: event.defaultIndex));
          },
        );
      }else{
        print("event is else");
      }
    });
  }
}
