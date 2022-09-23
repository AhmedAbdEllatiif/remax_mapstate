import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';

part 'project_status_backdrop_event.dart';

part 'project_status_backdrop_state.dart';

class ProjectStatusBackdropBloc
    extends Bloc<ProjectStatusBackdropEvent, ProjectStatusBackdropState> {
  ProjectStatusBackdropBloc() : super(ProjectBackdropInitial()) {
    on<ProjectStatusBackdropEvent>((event, emit) async {
      if (event is ProjectBackdropChangedEvent) {
        if (!isClosed) {
          emit(ProjectBackdropChangedState(
              projectStatusEntity: event.projectStatusEntity));
        }
      }
    });
  }
}
