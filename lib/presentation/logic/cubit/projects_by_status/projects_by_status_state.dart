part of 'projects_by_status_cubit.dart';

abstract class ProjectsByStatusState extends Equatable {
  const ProjectsByStatusState();

  @override
  List<Object> get props => [];
}

/// initial
class ProjectsByStatusInitial extends ProjectsByStatusState {}

/// loading more projects
class LoadingMoreProjectsByStatus extends ProjectsByStatusState {}

/// loading
class LoadingProjectsByStatus extends ProjectsByStatusState {}

/// empty
class EmptyProjectsByStatus extends ProjectsByStatusState {}

/// loaded
class ProjectsByStatusFetched extends ProjectsByStatusState {
  final List<ProjectEntity> projects;

  const ProjectsByStatusFetched({
    required this.projects,
  });

  @override
  List<Object> get props => [projects];
}

/// last page fetched loaded
class LastPageProjectsByStatusReached extends ProjectsByStatusState {
  final List<ProjectEntity> projects;

  const LastPageProjectsByStatusReached({
    required this.projects,
  });

  @override
  List<Object> get props => [projects];
}

/// Error
class ErrorWhileLoadingProjectsByStatus extends ProjectsByStatusState {
  final AppError appError;

  const ErrorWhileLoadingProjectsByStatus({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}

/// Error loading more projects
class ErrorWhileLoadingMoreProjectsByStatus extends ProjectsByStatusState {
  final AppError appError;

  const ErrorWhileLoadingMoreProjectsByStatus({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
