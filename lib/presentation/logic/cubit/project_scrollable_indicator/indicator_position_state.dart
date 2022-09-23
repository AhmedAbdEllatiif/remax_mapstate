part of 'indicator_position_cubit.dart';

class IndicatorPositionState extends Equatable {

  final double currentPosition;

  const IndicatorPositionState({required this.currentPosition});

  @override
  List<Object> get props => [currentPosition];
}


