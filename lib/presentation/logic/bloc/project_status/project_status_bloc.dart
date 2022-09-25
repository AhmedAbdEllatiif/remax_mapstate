import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_project_status.dart';

import '../../../../common/enums/app_language.dart';
import '../../../../data/models/page_info.dart';
import '../../../../data/params/fetch_list_params.dart';
import '../../cubit/language/language_cubit.dart';
import '../project_status_backdrop/project_status_backdrop_bloc.dart';

part 'project_status_event.dart';

part 'project_status_state.dart';

class ProjectStatusBloc extends Bloc<ProjectStatusEvent, ProjectStatusState> {
  final ProjectStatusBackdropBloc backdropBloc;
  final GetProjectStatusCase getProjectStatusCase;

  ProjectStatusBloc({
    required this.getProjectStatusCase,
    required this.backdropBloc,
  }) : super(LoadingProjectStatus()) {
    on<ProjectStatusEvent>((event, emit) async {
      void _emitIfNotClosed(ProjectStatusState state) {
        if (!isClosed) {
          emit(state);
        }
      }

      if (event is LoadProjectStatusEvent) {
        // init current language

        final appLanguage =
            event.languageCode == "en" ? AppLanguage.en : AppLanguage.ar;

        // init params
        final params = FetchListParams(
          appLanguage: appLanguage,
          pageInfo: PageInfo(),
          filters: [],
        );

        // send request fetch project status
        final either = await getProjectStatusCase(params);

        either.fold(
          (appError) {
            _emitIfNotClosed(ErrorLoadingProjectStatus(appError: appError));
          },
          (projectStatusList) {
            if (projectStatusList.isEmpty) {
              // add BackdropChangedEvent
              backdropBloc.add(ProjectBackdropChangedEvent(
                  projectStatusEntity: ProjectStatusEntity.empty()));
              // emit empty
              _emitIfNotClosed(EmptyProjectStatus());
            } else {
              // add BackdropChangedEvent
              backdropBloc.add(ProjectBackdropChangedEvent(
                  projectStatusEntity: projectStatusList[event.defaultIndex]));

              // emit TopProjectsLoadedState
              _emitIfNotClosed(ProjectStatusLoadedState(
                  projectStatusList: projectStatusList,
                  defaultIndex: event.defaultIndex));
            }
          },
        );
      }
    });
  }
}
