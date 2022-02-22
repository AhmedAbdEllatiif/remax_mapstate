part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class RequestPinCodeEvent extends LoginEvent{

  final LoginParams loginParams;

  const RequestPinCodeEvent({
    required this.loginParams,
  });

  @override
  List<Object?> get props => [loginParams];
}

class OnPinChanged extends LoginEvent{
   String changedPin;

   OnPinChanged({
    required this.changedPin,
  });
}


class ResendPinCode extends LoginEvent{}


class VerifyPinCodeEvent extends LoginEvent{


  const VerifyPinCodeEvent();

  @override
  List<Object?> get props => [];
}