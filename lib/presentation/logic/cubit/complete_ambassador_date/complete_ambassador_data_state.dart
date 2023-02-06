part of 'complete_ambassador_data_cubit.dart';

abstract class CompleteAmbassadorDataState extends Equatable {
  const CompleteAmbassadorDataState();

  @override
  List<Object> get props => [];
}

/// initial
class CompleteAmbassadorDataInitial extends CompleteAmbassadorDataState {}

/// loading
class LoadingCompleteAmbassadorDataInitial extends CompleteAmbassadorDataState {
}

/// unAuthorized
class UnAuthorizedCompleteAmbassadorDataInitial
    extends CompleteAmbassadorDataState {}

/// success
class AmbassadorDataCompletedSuccessfully extends CompleteAmbassadorDataState {}

/// error
class ErrorWhileCompletingAmbassadorData extends CompleteAmbassadorDataState {
  final AppError appError;

  const ErrorWhileCompletingAmbassadorData({required this.appError});

  @override
  List<Object> get props => [appError];
}
