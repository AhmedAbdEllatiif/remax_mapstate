part of 'project_status_bloc.dart';

abstract class ProjectStatusState extends Equatable {
  const ProjectStatusState();

  @override
  List<Object> get props => [];
}

/// loading
class LoadingProjectStatus extends ProjectStatusState {}

/// empty
class EmptyProjectStatus extends ProjectStatusState {
  final ProjectStatusEntity projectStatusEntity = ProjectStatusEntity.empty();

  EmptyProjectStatus();
}

/// fetched
class ProjectStatusLoadedState extends ProjectStatusState {
  final List<ProjectStatusEntity> projectStatusList;
  final int defaultIndex;

  const ProjectStatusLoadedState({
    required this.projectStatusList,
    this.defaultIndex = 0,
  });

  @override
  List<Object> get props => [projectStatusList, defaultIndex];
}

/// error
class ErrorLoadingProjectStatus extends ProjectStatusState {
  final AppError appError;

  const ErrorLoadingProjectStatus({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
