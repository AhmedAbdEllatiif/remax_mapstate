part of 'project_backdrop_bloc.dart';

abstract class ProjectBackdropState extends Equatable {
  const ProjectBackdropState();
  @override
  List<Object> get props => [];
}



// Initial state
class ProjectBackdropInitial extends ProjectBackdropState {}

// Backdrop changed state
class ProjectBackdropChangedState extends ProjectBackdropState {

  final ProjectEntity projectEntity;

  const ProjectBackdropChangedState({
    required this.projectEntity,
  });

  @override
  List<Object> get props => [projectEntity];

}
