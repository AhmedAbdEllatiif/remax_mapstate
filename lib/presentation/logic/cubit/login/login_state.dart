part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

/// initial
class LoginInitial extends LoginState {}

/// loading
class LoadingLogin extends LoginState {}

/// wrong email or password
class WrongEmailOrPassword extends LoginState {}

/// success
class LoginSuccess extends LoginState {
  final LoginEntity loginEntity;

  const LoginSuccess({required this.loginEntity});

  @override
  List<Object> get props => [loginEntity];
}

/// error
class ErrorWhileLogin extends LoginState {
  final AppError appError;

  const ErrorWhileLogin({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
