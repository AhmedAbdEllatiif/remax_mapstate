part of 'project_status_bloc.dart';

abstract class ProjectStatusState extends Equatable {
  const ProjectStatusState();
  @override
  List<Object> get props => [];
}



class ProjectStatusLoadingState extends ProjectStatusState {}

class ProjectStatusLoadedState extends ProjectStatusState {
  final List<ProjectStatusEntity> projectStatus;
  final int defaultIndex;

  const ProjectStatusLoadedState({
    required this.projectStatus,
    this.defaultIndex = 0,
  });

  @override
  List<Object> get props => [projectStatus,defaultIndex];
}

class ErrorLoadingProjectStatus extends ProjectStatusState {
  final AppError appError;

  const ErrorLoadingProjectStatus({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
