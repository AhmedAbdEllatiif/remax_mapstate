import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_project_status.dart';
import 'package:remax_mapstate/presentation/bloc/project_status_backdrop/project_status_backdrop_bloc.dart';

part 'project_status_event.dart';

part 'project_status_state.dart';

class ProjectStatusBloc extends Bloc<ProjectStatusEvent, ProjectStatusState> {
  final ProjectStatusBackdropBloc backdropBloc;
  final GetProjectStatusCase getProjectStatusCase;

  ProjectStatusBloc({
    required this.getProjectStatusCase,
    required this.backdropBloc,
  }) : super(ProjectStatusLoadingState()) {
    on<ProjectStatusEvent>((event, emit) async {

      void _emitIfNotClosed(ProjectStatusState state){
        if(!isClosed){
          emit(state);
        }
      }

      if (event is LoadProjectStatusEvent) {

        final either = await getProjectStatusCase(NoParams());
        either.fold(
          (appError) {

            _emitIfNotClosed(ErrorLoadingProjectStatus(appError: appError));
          },
          (projectStatus) {
            // add BackdropChangedEvent
            backdropBloc.add(ProjectBackdropChangedEvent(
                projectStatusEntity: projectStatus[event.defaultIndex]));

            // emit TopProjectsLoadedState
            _emitIfNotClosed(ProjectStatusLoadedState(
                projectStatus: projectStatus,
                defaultIndex: event.defaultIndex));
          },
        );
      }
    });
  }
}
