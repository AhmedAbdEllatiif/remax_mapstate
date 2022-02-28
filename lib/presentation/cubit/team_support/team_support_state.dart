part of 'team_support_cubit.dart';

abstract class TeamSupportState extends Equatable {
  final TeamSupportEntity? teamSupportEntity;

  const TeamSupportState({
    this.teamSupportEntity,
  });

  @override
  List<Object> get props => [];
}

/// Loading
class LoadingTeamSupportState extends TeamSupportState {}

/// With image
class TeamSupportDataLoaded extends TeamSupportState {
  final TeamSupportEntity teamSupportEntity;

  const TeamSupportDataLoaded({
    required this.teamSupportEntity,
  }) : super(teamSupportEntity:teamSupportEntity);

  @override
  List<Object> get props => [teamSupportEntity];
}



/// Error
class TeamSupportErrorState extends TeamSupportState {
  final AppError appError;

  const TeamSupportErrorState({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}