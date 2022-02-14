part of 'project_status_backdrop_bloc.dart';

abstract class ProjectStatusBackdropEvent extends Equatable {
  const ProjectStatusBackdropEvent();

  @override
  List<Object?> get props => [];
}


class ProjectBackdropChangedEvent extends ProjectStatusBackdropEvent {

  final ProjectStatusEntity projectStatusEntity;

  const ProjectBackdropChangedEvent({
    required this.projectStatusEntity,
  });

  @override
  List<Object?> get props => [projectStatusEntity];
}