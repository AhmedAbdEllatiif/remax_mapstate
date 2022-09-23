part of 'current_user_cubit.dart';

class CurrentUserState extends Equatable {
  final UserType userType;

  const CurrentUserState({required this.userType});

  @override
  List<Object> get props => [userType];
}
