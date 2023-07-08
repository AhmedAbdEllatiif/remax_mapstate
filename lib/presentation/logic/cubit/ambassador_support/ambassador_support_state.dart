part of 'ambassador_support_cubit.dart';

abstract class AmbassadorSupportState extends Equatable {
  const AmbassadorSupportState();
  @override
  List<Object> get props => [];
}

/// initial
class AmbassadorSupportStateInitial extends AmbassadorSupportState {}

/// Loading
class LoadingAmbassadorSupportState extends AmbassadorSupportState {}

/// empty
class NoAmbassadorSupportFound extends AmbassadorSupportState {}

/// success
class AmbassadorSupportDataLoaded extends AmbassadorSupportState {
  final AmbassadorSupportEntity ambassadorSupportEntity;

  const AmbassadorSupportDataLoaded({
    required this.ambassadorSupportEntity,
  });

  @override
  List<Object> get props => [ambassadorSupportEntity];
}

/// Error
class ErrorWhileLoadingAmbassadorSupport extends AmbassadorSupportState {
  final AppError appError;

  const ErrorWhileLoadingAmbassadorSupport({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}