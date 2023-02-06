part of 'update_ambassador_data_cubit.dart';

abstract class UpdateAmbassadorDataState extends Equatable {
  const UpdateAmbassadorDataState();

  @override
  List<Object> get props => [];
}

/// initial
class UpdateAmbassadorDataInitial extends UpdateAmbassadorDataState {}

/// loading
class LoadingUpdateAmbassadorData extends UpdateAmbassadorDataState {}

/// unAuthorized
class UnAuthorizedUpdateAmbassadorData extends UpdateAmbassadorDataState {}

/// success
class AmbassadorDataUpdatedSuccessfully extends UpdateAmbassadorDataState {}

/// error
class ErrorWhileUpdatingAmbassadorData extends UpdateAmbassadorDataState {
  final AppError appError;

  const ErrorWhileUpdatingAmbassadorData({required this.appError});

  @override
  List<Object> get props => [appError];
}
