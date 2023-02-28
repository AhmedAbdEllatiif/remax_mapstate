part of 'team_support_cubit.dart';

abstract class TeamSupportState extends Equatable {
  const TeamSupportState();

  @override
  List<Object> get props => [];
}

/// initial
class TeamSupportStateInitial extends TeamSupportState {}

/// Loading
class LoadingTeamSupportState extends TeamSupportState {}

/// empty
class NoTeamSupportFound extends TeamSupportState {}

/// success
class TeamSupportDataLoaded extends TeamSupportState {
  final TeamSupportEntity teamSupportEntity;

  const TeamSupportDataLoaded({
    required this.teamSupportEntity,
  });

  @override
  List<Object> get props => [teamSupportEntity];
}

/// Error
class ErrorWhileLoadingTeamSupport extends TeamSupportState {
  final AppError appError;

  const ErrorWhileLoadingTeamSupport({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
