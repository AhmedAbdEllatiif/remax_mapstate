part of 'register_new_user_cubit.dart';

abstract class RegisterNewUserState extends Equatable {
  const RegisterNewUserState();

  @override
  List<Object> get props => [];
}

/// initial
class RegisterInitial extends RegisterNewUserState {}

/// loading
class LoadingToRegister extends RegisterNewUserState {}

/// email already exists
class RegisterEmailAlreadyExists extends RegisterNewUserState {}

/// password is missing
class RegisterPasswordIsMissing extends RegisterNewUserState {}

/// success
class SuccessRegister extends RegisterNewUserState {
  final RegisterEntity registerEntity;

  const SuccessRegister({required this.registerEntity});

  @override
  List<Object> get props => [registerEntity];
}

/// error
class ErrorWhileRegister extends RegisterNewUserState {
  final AppError appError;

  const ErrorWhileRegister({required this.appError});

  @override
  List<Object> get props => [appError];
}
