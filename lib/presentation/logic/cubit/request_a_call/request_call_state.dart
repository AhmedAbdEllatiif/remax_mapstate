part of 'request_call_cubit.dart';

abstract class RequestCallState extends Equatable {
  const RequestCallState();

  @override
  List<Object> get props => [];
}

class RequestCallInitial extends RequestCallState {}

/// Loading
class LoadingRequestCall extends RequestCallState {}

/// unAuthenticated
class UnAuthenticatedToRequestCall extends RequestCallState {}

/// success
class RequestCallSuccessfullySent extends RequestCallState {}

/// a call is already request for this project
class AlreadyRequestOnThisProject extends RequestCallState {}

/// Error
class ErrorWhileRequestingCall extends RequestCallState {
  final AppError appError;

  const ErrorWhileRequestingCall({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
