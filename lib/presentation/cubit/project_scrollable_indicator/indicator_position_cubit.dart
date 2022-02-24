import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'indicator_position_state.dart';

class IndicatorPositionCubit extends Cubit<IndicatorPositionState> {
  IndicatorPositionCubit()
      : super(const IndicatorPositionState(currentPosition: 0));

  /// To update current active position
  void updatePosition(double currentIndex) {
    if (!isClosed) {
      emit(IndicatorPositionState(currentPosition: currentIndex));
    }
  }
}
