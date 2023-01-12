part of 'get_current_user_profile_cubit.dart';

abstract class GetCurrentUserProfileState extends Equatable {
  const GetCurrentUserProfileState();

  @override
  List<Object> get props => [];
}

/// initial
class GetProfileInitial extends GetCurrentUserProfileState {}

/// loading
class LoadingToGetProfile extends GetCurrentUserProfileState {}

/// unAuthorized
class UnAuthorizedToGetProfile extends GetCurrentUserProfileState {}

/// success
class ProfileDataFetchedSuccessfully extends GetCurrentUserProfileState {
  final ProfileEntity profileEntity;

  const ProfileDataFetchedSuccessfully({required this.profileEntity});

  @override
  List<Object> get props => [profileEntity];
}

/// error
class ErrorWhileFetchingProfile extends GetCurrentUserProfileState {
  final AppError appError;

  const ErrorWhileFetchingProfile({required this.appError});

  @override
  List<Object> get props => [appError];
}
