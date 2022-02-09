part of 'favorite_projects_bloc.dart';

abstract class FavoriteProjectsState extends Equatable {
  const FavoriteProjectsState();

  @override
  List<Object?> get props => [];
}


class FavoriteProjectsLoading extends FavoriteProjectsState {}


/// When there are no favoriteProjects to show
class FavoriteProjectsNoProjectsToShow extends FavoriteProjectsState {}


/// FavoriteProjectsLoadedState
class FavoriteProjectsLoadedState extends FavoriteProjectsState {
  final List<ProjectEntity> projects;

  const FavoriteProjectsLoadedState({
    required this.projects,
  });

  @override
  List<Object> get props => [projects];
}


/// IsFavoriteProjectState
class IsFavoriteProjectState extends FavoriteProjectsState {
  final bool isProjectFavorite;

  const IsFavoriteProjectState({
    required this.isProjectFavorite,
  });

  @override
  List<Object> get props => [isProjectFavorite];
}

/// IsFavoriteProjectState
class FavoriteProjectsErrorState extends FavoriteProjectsState {
  final AppError appError;

  const FavoriteProjectsErrorState({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}


