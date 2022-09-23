part of 'areas_cubit.dart';

abstract class AreasState extends Equatable {
  const AreasState();
  @override
  List<Object> get props => [];
}


/// loading
class LoadingAreas extends AreasState {}

/// loaded
class AreasFetched extends AreasState{

  final List<AreaEntity> areas;

  const AreasFetched({
    required this.areas,
  });

  @override
  List<Object> get props => [areas];
}

/// Error
class ErrorWhileLoadingAreas extends AreasState{

  final AppError appError;

  const ErrorWhileLoadingAreas({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];

}