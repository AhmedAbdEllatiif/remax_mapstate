part of 'get_fav_projects_cubit.dart';

abstract class GetFavProjectsState extends Equatable {
  const GetFavProjectsState();

  @override
  List<Object> get props => [];
}

/// initial
class FavProjectsInitial extends GetFavProjectsState {}

/// unAuthorized
class UnAuthorizedToFetchFavProjects extends GetFavProjectsState {}

/// loading more projects
class LoadingMoreFavProjects extends GetFavProjectsState {}

/// loading
class LoadingFavProjects extends GetFavProjectsState {}

/// empty
class EmptyFavProjects extends GetFavProjectsState {}

/// loaded
class FavProjectsFetched extends GetFavProjectsState {
  final List<ProjectEntity> projects;

  const FavProjectsFetched({
    required this.projects,
  });

  @override
  List<Object> get props => [projects];
}

/// last page fetched loaded
class LastPageFavProjectsReached extends GetFavProjectsState {
  final List<ProjectEntity> projects;

  const LastPageFavProjectsReached({
    required this.projects,
  });

  @override
  List<Object> get props => [projects];
}

/// Error
class ErrorWhileLoadingFavProjects extends GetFavProjectsState {
  final AppError appError;

  const ErrorWhileLoadingFavProjects({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}

/// Error loading more projects
class ErrorWhileLoadingMoreFavProjects extends GetFavProjectsState {
  final AppError appError;

  const ErrorWhileLoadingMoreFavProjects({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}

