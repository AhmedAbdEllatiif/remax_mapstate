import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/use_cases/get_projects.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

part 'fetch_projects_event.dart';

part 'fetch_projects_state.dart';

class FetchProjectsBloc extends Bloc<FetchProjectsEvent, FetchProjectsState> {

  final GetProjectsCase getProjects;

  FetchProjectsBloc({required this.getProjects,})
      : super(FetchProjectsLoading()) {



    on<FetchProjectsEvent>((event, emit) async {


      void _emitIfNotClosed(FetchProjectsState state){
        if(!isClosed){
          emit(state);
        }
      }

      if (event is LoadFetchProjectsEvent) {

        final either = await getProjects(NoParams());
        either.fold(
          (appError) {

            _emitIfNotClosed(ErrorLoadingFetchProjects(appError: appError));
          },
          (projects) {

            // emit TopProjectsLoadedState
            _emitIfNotClosed(FetchProjectsLoadedState(
                projects: projects, defaultIndex: event.defaultIndex));
          },
        );
      }
    });
  }
}
