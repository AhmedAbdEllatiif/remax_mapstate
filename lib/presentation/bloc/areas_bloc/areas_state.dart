part of 'areas_bloc.dart';

abstract class AreasState extends Equatable {
  const AreasState();
  @override
  List<Object> get props => [];
}


/// loading
class AreasLoadingState extends AreasState {}

/// loaded
class AreasLoadedState extends AreasState{

  final List<AreaEntity> areas;

  const AreasLoadedState({
    required this.areas,
  });

  @override
  List<Object> get props => [areas];
}

/// Error
class AreasErrorState extends AreasState{

  final AppError appError;

  const AreasErrorState({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];

}