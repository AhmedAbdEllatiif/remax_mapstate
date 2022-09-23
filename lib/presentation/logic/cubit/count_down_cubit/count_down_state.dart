part of 'count_down_cubit.dart';

abstract class CountDownState extends Equatable {
  const CountDownState();
  @override
  List<Object> get props => [];
}


/// Initial
class CountDownInitial extends CountDownState {}



/// Count started
class CountDownStarted extends CountDownState{

  final CountdownTimerController timerController;

  const CountDownStarted({
    required this.timerController,
  });

  @override
  List<Object> get props => [timerController];
}


/// Count ended
class CountDownEnded extends CountDownState {}

