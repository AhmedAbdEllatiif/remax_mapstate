part of 'residential_projects_cubit.dart';

abstract class ResidentialProjectsState extends Equatable {
  const ResidentialProjectsState();

  @override
  List<Object> get props => [];
}

/// Initial State
class ResidentialProjectsInitial extends ResidentialProjectsState {}


/// Loading State
class ResidentialProjectsLoadingState extends ResidentialProjectsState {}

/// NoProjectsTo State
class NoResidentialProjectsToShowState extends ResidentialProjectsState {}


/// Error State
class ResidentialProjectsErrorState extends ResidentialProjectsState {

  final AppError appError;

  const ResidentialProjectsErrorState({
    required this.appError,
  });
  @override
  List<Object> get props => [appError];
}

/// Loaded State
class ResidentialProjectsLoadedState extends ResidentialProjectsState {

  final List<ProjectEntity> projects;

  const ResidentialProjectsLoadedState({
    required this.projects,
  });

  @override
  List<Object> get props => [projects];
}