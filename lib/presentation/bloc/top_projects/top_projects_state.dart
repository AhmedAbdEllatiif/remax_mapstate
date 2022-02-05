part of 'top_projects_bloc.dart';

abstract class TopProjectsState extends Equatable {
  const TopProjectsState();

  @override
  List<Object> get props => [];
}

class TopProjectsInitial extends TopProjectsState {}

class TopProjectsLoadedState extends TopProjectsState {
  final List<ProjectEntity> projects;
  final int defaultIndex;

  const TopProjectsLoadedState({
    required this.projects,
    this.defaultIndex = 0,
  });

  @override
  List<Object> get props => [projects,defaultIndex];
}

class ErrorLoadingTopProjects extends TopProjectsState {
  final AppError appError;

  const ErrorLoadingTopProjects({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
