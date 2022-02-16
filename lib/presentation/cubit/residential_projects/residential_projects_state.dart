part of 'residential_projects_cubit.dart';

abstract class ResidentialState extends Equatable {
  const ResidentialState();

  @override
  List<Object> get props => [];
}

/// Initial State
class ResidentialInitial extends ResidentialState {}


/// Loading State
class ResidentialLoadingState extends ResidentialState {}

/// No projects to show State
class NoProjectsToShowState extends ResidentialState {}


/// Error State
class ResidentialCubitErrorState extends ResidentialState {

  final AppError appError;

  const ResidentialCubitErrorState({
    required this.appError,
  });
  @override
  List<Object> get props => [appError];
}




/// Projects Loaded State
class ProjectsLoadedState extends ResidentialState {

  final List<ProjectEntity> projects;

  const ProjectsLoadedState({
    required this.projects,
  });

  @override
  List<Object> get props => [projects];
}



///******************************* UnitTypes *******************************\\\

/// No unitTypes to show State
class NoUnitTypesToShowState extends ResidentialState {}


/// UnitTypes Loaded State
class UnitTypesLoadedState extends ResidentialState {

  final List<UnitTypeEntity> unitTypes;

  const UnitTypesLoadedState({
    required this.unitTypes,
  });

  @override
  List<Object> get props => [unitTypes];
}