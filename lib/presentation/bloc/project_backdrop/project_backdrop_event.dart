part of 'project_backdrop_bloc.dart';

abstract class ProjectBackdropEvent extends Equatable {
  const ProjectBackdropEvent();

  @override
  List<Object?> get props => [];
}


class ProjectBackdropChangedEvent extends ProjectBackdropEvent {

  final ProjectEntity projectEntity;

  const ProjectBackdropChangedEvent({
    required this.projectEntity,
  });

  @override
  List<Object?> get props => [projectEntity];
}