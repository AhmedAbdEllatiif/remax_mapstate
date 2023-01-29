part of 'check_current_favorite_project_cubit.dart';

abstract class CheckCurrentFavoriteProjectState extends Equatable {
  const CheckCurrentFavoriteProjectState();

  @override
  List<Object> get props => [];
}

class CheckCurrentFavoriteProjectInitial
    extends CheckCurrentFavoriteProjectState {}

/// loading
class LoadingCheckFavoriteProject extends CheckCurrentFavoriteProjectState {}

/// unAuthorized
class UnAuthorizedToCheckFavoriteProject
    extends CheckCurrentFavoriteProjectState {}

/// succeed
class CurrentProjectFavOrNotResult extends CheckCurrentFavoriteProjectState {
  final bool isFavoriteProject;

  const CurrentProjectFavOrNotResult({required this.isFavoriteProject});

  @override
  List<Object> get props => [isFavoriteProject];
}

/// error
class ErrorWhileGettingFavProjectIds extends CheckCurrentFavoriteProjectState {
  final AppError appError;

  const ErrorWhileGettingFavProjectIds({required this.appError});

  @override
  List<Object> get props => [appError];
}
