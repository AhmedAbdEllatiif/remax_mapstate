part of 'authorized_user_cubit.dart';

abstract class AuthorizedUserState extends Equatable {
  final AuthorizedUserEntity userEntity;
  late final UserType currentUserType;

  AuthorizedUserState(this.userEntity) {
    currentUserType = userEntity.userType;
  }

  @override
  List<Object?> get props => [userEntity];
}

// /// current data of the current authorized user
// class CurrentAuthorizedUserData extends AuthorizedUserState {
//   CurrentAuthorizedUserData({required AuthorizedUserEntity userEntity})
//       : super(userEntity);
// }

/// broker data
class CurrentBrokerAuthorizedUserData extends AuthorizedUserState {
  CurrentBrokerAuthorizedUserData({required AuthorizedUserEntity userEntity})
      : super(userEntity);
}

/// ambassador data
class CurrentAmbassadorAuthorizedUserData extends AuthorizedUserState {
  CurrentAmbassadorAuthorizedUserData(
      {required AuthorizedUserEntity userEntity})
      : super(userEntity);
}

/// buyer data
class CurrentBuyerAuthorizedUserData extends AuthorizedUserState {
  CurrentBuyerAuthorizedUserData({required AuthorizedUserEntity userEntity})
      : super(userEntity);
}

/// buyer data
class UnDefinedAuthorizedUserData extends AuthorizedUserState {
  UnDefinedAuthorizedUserData() : super(AuthorizedUserEntity.empty());
}

/// error
class CurrentAuthorizedUserDataError extends AuthorizedUserState {
  final AppError appError;

  CurrentAuthorizedUserDataError({
    required this.appError,
  }) : super(AuthorizedUserEntity.empty());

  @override
  List<Object?> get props => [appError];
}
