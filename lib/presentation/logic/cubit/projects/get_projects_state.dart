part of 'get_projects_cubit.dart';

abstract class GetProjectsState extends Equatable {
  const GetProjectsState();

  @override
  List<Object> get props => [];
}

/// loading
class LoadingProjects extends GetProjectsState {}

/// empty list of projects
class EmptyListProjects extends GetProjectsState {}

/// fetched
class ProjectsFetched extends GetProjectsState {
  final List<ProjectEntity> projects;

  const ProjectsFetched({
    required this.projects,
  });

  @override
  List<Object> get props => [projects];
}

/// error
class ErrorLoadingFetchProjects extends GetProjectsState {
  final AppError appError;

  const ErrorLoadingFetchProjects({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
