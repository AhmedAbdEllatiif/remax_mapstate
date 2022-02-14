part of 'fetch_projects_bloc.dart';

abstract class FetchProjectsEvent extends Equatable {
  const FetchProjectsEvent();

  @override
  List<Object?> get props => [];
}



class LoadFetchProjectsEvent extends FetchProjectsEvent {
  final int defaultIndex;

  const LoadFetchProjectsEvent({
     this.defaultIndex = 0,
  });

  @override
  List<Object?> get props => [defaultIndex];
}