part of 'get_ambassador_by_id_cubit.dart';

abstract class GetAmbassadorByIdState extends Equatable {
  const GetAmbassadorByIdState();

  @override
  List<Object?> get props => [];
}

/// initial
class GetAmbassadorByIdInitial extends GetAmbassadorByIdState {}

/// loading
class LoadingGetAmbassadorById extends GetAmbassadorByIdState {}

/// unAuthorized
class UnAuthorizedToGetAmbassadorById extends GetAmbassadorByIdState {}

/// NotAAmbassadorBeforeGettingAmbassadorById means the stored
/// Authorized id is -1
class NotAAmbassadorBeforeGettingAmbassadorById extends GetAmbassadorByIdState {
}

/// trying to fetch ambassador by id but not found
class AmbassadorNotFoundById extends GetAmbassadorByIdState {}

/// not a completed Ambassador data
class NotCompletedDataForAmbassador extends GetAmbassadorByIdState {
  final AmbassadorEntity ambassadorEntity;

  const NotCompletedDataForAmbassador({required this.ambassadorEntity});

  @override
  List<Object> get props => [ambassadorEntity];
}

/// success
class AmbassadorDataFetched extends GetAmbassadorByIdState {
  final AmbassadorEntity ambassadorEntity;

  const AmbassadorDataFetched({required this.ambassadorEntity});

  @override
  List<Object> get props => [ambassadorEntity];
}

/// error
class ErrorWhileGettingAmbassadorById extends GetAmbassadorByIdState {
  final AppError appError;

  const ErrorWhileGettingAmbassadorById({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
