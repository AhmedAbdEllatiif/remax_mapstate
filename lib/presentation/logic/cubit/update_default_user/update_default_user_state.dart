part of 'update_default_user_cubit.dart';

abstract class UpdateDefaultUserState extends Equatable {
  const UpdateDefaultUserState();

  @override
  List<Object> get props => [];
}

/// initial
class UpdateDefaultUserInitial extends UpdateDefaultUserState {}

/// loading
class LoadingToUpdateDefaultUser extends UpdateDefaultUserState {}

/// email already exists
class UpdateDefaultUserEmailAlreadyExists extends UpdateDefaultUserState {}

/// password is missing
class UpdateDefaultUserPasswordIsMissing extends UpdateDefaultUserState {}

/// success
class SuccessUpdateDefaultUser extends UpdateDefaultUserState {
  final UserEntity userEntity;

  const SuccessUpdateDefaultUser({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}

/// error
class ErrorWhileUpdatingDefaultUser extends UpdateDefaultUserState {
  final AppError appError;

  const ErrorWhileUpdatingDefaultUser({required this.appError});

  @override
  List<Object> get props => [appError];
}
