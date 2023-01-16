part of 'contact_us_cubit.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

/// initial
class ContactUsInitial extends ContactUsState {}

/// loading
class LoadingToSendContactUs extends ContactUsState {}

/// unAuthenticated
class UnAuthenticatedToContactUs extends ContactUsState {}

/// success
class ContactUsSentSuccessfully extends ContactUsState {}

///error
class ErrorWhileSendingContactUs extends ContactUsState {
  final AppError appError;

  const ErrorWhileSendingContactUs({required this.appError});

  @override
  List<Object> get props => [appError];
}
