part of 'advanced_filter_projects_cubit.dart';

abstract class AdvancedFilterProjectsState extends Equatable {
  const AdvancedFilterProjectsState();

  @override
  List<Object> get props => [];
}

/// initial
class AdvancedFilterProjectsInitial extends AdvancedFilterProjectsState {}

/// unAuthorized
class UnAuthorizedFilterProjects extends AdvancedFilterProjectsState {}

/// loading more projects
class LoadingMoreAdvancedFilterProjects extends AdvancedFilterProjectsState {}

/// loading
class LoadingAdvancedFilterProjects extends AdvancedFilterProjectsState {}

/// empty
class EmptyAdvancedFilterProjects extends AdvancedFilterProjectsState {}

/// loaded
class AdvancedFilterProjectsFetched extends AdvancedFilterProjectsState {
  final List<ProjectEntity> projects;

  const AdvancedFilterProjectsFetched({
    required this.projects,
  });

  @override
  List<Object> get props => [projects];
}

/// last page fetched loaded
class LastPageAdvancedFilterProjectsReached
    extends AdvancedFilterProjectsState {
  final List<ProjectEntity> projects;

  const LastPageAdvancedFilterProjectsReached({
    required this.projects,
  });

  @override
  List<Object> get props => [projects];
}

/// Error
class ErrorWhileLoadingAdvancedFilterProjects
    extends AdvancedFilterProjectsState {
  final AppError appError;

  const ErrorWhileLoadingAdvancedFilterProjects({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}

/// Error loading more projects
class ErrorWhileLoadingMoreAdvancedFilterProjects
    extends AdvancedFilterProjectsState {
  final AppError appError;

  const ErrorWhileLoadingMoreAdvancedFilterProjects({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
