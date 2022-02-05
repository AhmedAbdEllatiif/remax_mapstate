import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

part 'project_backdrop_event.dart';

part 'project_backdrop_state.dart';

class ProjectBackdropBloc
    extends Bloc<ProjectBackdropEvent, ProjectBackdropState> {
  ProjectBackdropBloc() : super(ProjectBackdropInitial()) {
    on<ProjectBackdropEvent>((event, emit) async {
      if (event is ProjectBackdropChangedEvent) {
        emit(ProjectBackdropChangedState(projectEntity: event.projectEntity));
      }
    });
  }
}
