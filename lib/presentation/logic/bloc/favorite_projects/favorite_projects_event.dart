part of 'favorite_projects_bloc.dart';

abstract class FavoriteProjectsEvent extends Equatable {
  const FavoriteProjectsEvent();

  @override
  List<Object?> get props => [];
}



/// LoadFavoriteProjectsEvent
class LoadFavoriteProjectsEvent extends FavoriteProjectsEvent {}

/// DeleteFavoriteProjectEvent
class DeleteFavoriteProjectEvent  extends FavoriteProjectsEvent {

  final int projectId;

  const DeleteFavoriteProjectEvent({
    required this.projectId,
  });

  @override
  List<Object?> get props => [projectId];
}

/// ToggleFavoriteProjectEvent
class ToggleFavoriteProjectEvent extends FavoriteProjectsEvent{

  final FavProjectEntity projectEntity;
  final bool isFavorite;


  const ToggleFavoriteProjectEvent({
    required this.projectEntity,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [projectEntity,isFavorite];

}


/// CheckFavoriteProjectEvent
class CheckFavoriteMovieEvent extends FavoriteProjectsEvent{
  final int projectId;

  const CheckFavoriteMovieEvent({
    required this.projectId,
  });

  @override
  List<Object?> get props => [projectId];
}



