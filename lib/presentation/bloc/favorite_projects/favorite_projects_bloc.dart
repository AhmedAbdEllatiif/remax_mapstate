import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/fav_project_entity.dart';
import 'package:remax_mapstate/domain/entities/params/project_param_entity.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/check_for_favorite_project.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/delete_fav_project.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/get_fav_projects.dart';
import 'package:remax_mapstate/domain/use_cases/local_usecases/save_fav_project.dart';
import '../../../domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

part 'favorite_projects_event.dart';

part 'favorite_projects_state.dart';

class FavoriteProjectsBloc
    extends Bloc<FavoriteProjectsEvent, FavoriteProjectsState> {


  /// UseCases
  final GetFavProjects getFavProjects;
  final SaveFavProject saveFavProject;
  final DeleteFavProject deleteFavProject;
  final CheckForFavProjectUseCase checkForFavProject;

  FavoriteProjectsBloc({
    required this.getFavProjects,
    required this.saveFavProject,
    required this.deleteFavProject,
    required this.checkForFavProject,
  }) : super(FavoriteProjectsLoading()) {
    on<FavoriteProjectsEvent>((event, emit) async {

      void _emitIfNotClosed(FavoriteProjectsState state){
        if(!isClosed){
          emit(state);
        }
      }

      ///==> fetchFavoriteProjects
      Future<void> _fetchFavoriteProjects() async {
        final response = await getFavProjects(NoParams());
        response.fold(
              (appError) =>
              _emitIfNotClosed(FavoriteProjectsErrorState(appError: appError)),
              (projects) {
            if (projects.isEmpty) {
              _emitIfNotClosed(FavoriteProjectsNoProjectsToShow());
            }
            else{
              _emitIfNotClosed(FavoriteProjectsLoadedState(projects: projects));
            }
          },
        );
      }

      /// Toggle event
      if (event is ToggleFavoriteProjectEvent) {
        if (event.isFavorite) {
          await deleteFavProject(
              ProjectParamEntity(projectId: event.projectEntity.id));
        } else {
          await saveFavProject(event.projectEntity);
        }

        final response = await checkForFavProject(
            ProjectParamEntity(projectId: event.projectEntity.id));
        response.fold(
              (appError) =>
              _emitIfNotClosed(FavoriteProjectsErrorState(appError: appError)),
              (isFavorite) =>
              _emitIfNotClosed(IsFavoriteProjectState(isProjectFavorite: isFavorite)),
        );
      }

      /// delete event
      if (event is DeleteFavoriteProjectEvent) {
        await deleteFavProject(ProjectParamEntity(projectId: event.projectId));
        await _fetchFavoriteProjects();
      }

      /// check event
      if (event is CheckFavoriteMovieEvent) {
        final response = await checkForFavProject(
            ProjectParamEntity(projectId: event.projectId));
        response.fold(
              (appError) =>
              _emitIfNotClosed(FavoriteProjectsErrorState(appError: appError)),
              (isFavorite) =>
              _emitIfNotClosed(IsFavoriteProjectState(isProjectFavorite: isFavorite)),
        );
      }

      /// load event
      if (event is LoadFavoriteProjectsEvent) {
        await _fetchFavoriteProjects();
      }
    });
  }
}
