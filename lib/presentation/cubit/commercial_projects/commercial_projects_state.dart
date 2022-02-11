part of 'commercial_projects_cubit.dart';

abstract class CommercialProjectsState extends Equatable {
  const CommercialProjectsState();
  @override
  List<Object> get props => [];
}



/// Initial State
class CommercialProjectsInitial extends CommercialProjectsState {}


/// Loading State
class CommercialProjectsLoadingState extends CommercialProjectsState {}

/// NoProjectsTo State
class NoCommercialProjectsToShowState extends CommercialProjectsState {}


/// Error State
class CommercialProjectsErrorState extends CommercialProjectsState {

  final AppError appError;

  const CommercialProjectsErrorState({
    required this.appError,
  });
  @override
  List<Object> get props => [appError];
}

/// Loaded State
class CommercialProjectsLoadedState extends CommercialProjectsState {

  final List<ProjectEntity> projects;

  const CommercialProjectsLoadedState({
    required this.projects,
  });

  @override
  List<Object> get props => [projects];
}
