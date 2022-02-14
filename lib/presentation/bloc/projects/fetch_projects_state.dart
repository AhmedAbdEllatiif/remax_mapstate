part of 'fetch_projects_bloc.dart';

abstract class FetchProjectsState extends Equatable {
  const FetchProjectsState();

  @override
  List<Object> get props => [];
}

class FetchProjectsLoading extends FetchProjectsState {}

class FetchProjectsLoadedState extends FetchProjectsState {
  final List<ProjectEntity> projects;
  final int defaultIndex;

  const FetchProjectsLoadedState({
    required this.projects,
    this.defaultIndex = 0,
  });

  @override
  List<Object> get props => [projects,defaultIndex];
}

class ErrorLoadingFetchProjects extends FetchProjectsState {
  final AppError appError;

  const ErrorLoadingFetchProjects({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
