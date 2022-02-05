part of 'top_projects_bloc.dart';

abstract class TopProjectsEvent extends Equatable {
  const TopProjectsEvent();

  @override
  List<Object?> get props => [];
}



class LoadTopProjectsEvent extends TopProjectsEvent {
  final int defaultIndex;

  const LoadTopProjectsEvent({
     this.defaultIndex = 0,
  });

  @override
  List<Object?> get props => [defaultIndex];
}