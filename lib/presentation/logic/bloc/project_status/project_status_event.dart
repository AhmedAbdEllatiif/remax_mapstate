part of 'project_status_bloc.dart';

abstract class ProjectStatusEvent extends Equatable {
  const ProjectStatusEvent();

  @override
  List<Object?> get props => [];
}
class LoadProjectStatusEvent extends ProjectStatusEvent {
  final int defaultIndex;

  const LoadProjectStatusEvent({
    this.defaultIndex = 0,
  });

  @override
  List<Object?> get props => [defaultIndex];
}