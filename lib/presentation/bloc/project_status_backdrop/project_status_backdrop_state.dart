part of 'project_status_backdrop_bloc.dart';

abstract class ProjectStatusBackdropState extends Equatable {
  const ProjectStatusBackdropState();
  @override
  List<Object> get props => [];
}



// Initial state
class ProjectBackdropInitial extends ProjectStatusBackdropState {}

// Backdrop changed state
class ProjectBackdropChangedState extends ProjectStatusBackdropState {

  final ProjectStatusEntity projectStatusEntity;

  const ProjectBackdropChangedState({
    required this.projectStatusEntity,
  });

  @override
  List<Object> get props => [projectStatusEntity];

}
