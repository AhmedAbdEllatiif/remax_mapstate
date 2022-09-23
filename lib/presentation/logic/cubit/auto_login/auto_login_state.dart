part of 'auto_login_cubit.dart';

abstract class AutoLoginState extends Equatable {
  final LoginStatus loginStatus;

  const AutoLoginState({required this.loginStatus});

  @override
  List<Object?> get props => [loginStatus];
}

class CurrentAutoLoginStatus extends AutoLoginState {
  const CurrentAutoLoginStatus({required LoginStatus loginStatus})
      : super(loginStatus: loginStatus);
}

class AutoLoginError extends AutoLoginState {
  final AppError appError;

  const AutoLoginError({
    required this.appError,
  }) : super(loginStatus: LoginStatus.notLoggedIn);

  @override
  List<Object?> get props => [appError];
}
