import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';

part 'count_down_state.dart';

class CountDownCubit extends Cubit<CountDownState> {
  late  CountdownTimerController? controller;

  CountDownCubit() : super(CountDownInitial()) {
    controller = null;
  }


  void _emitIfNotClosed(CountDownState state){
    if(!isClosed){
      emit(state);
    }
  }


  /// Start counting
  void startCountDown() {
    controller = _getController(timeInSec: 10);
    _emitIfNotClosed(CountDownStarted(timerController: controller!));
  }

  /// Event sent from UI to end the countDown
  void endCountDown() {
    if (controller != null) {
      _emitIfNotClosed(CountDownEnded());
      _clearController();
    }
  }


  /// return new Instance of CountdownTimerController
  CountdownTimerController _getController({int timeInSec = 10}) {
    controller = null;
    final int endTime =
        DateTime.now().millisecondsSinceEpoch + 1000 * timeInSec;
    controller = CountdownTimerController(endTime: endTime, onEnd: _onCountDownEnded);
    return controller!;
  }

  /// Callback When the countDown timer is finished
  void _onCountDownEnded() {
    _emitIfNotClosed(CountDownEnded());
    _clearController();
  }

  /// To clear the controller
  void _clearController() {
    if (controller != null) {
      controller!.dispose();
    }
  }

  @override
  Future<void> close() {
    _clearController();
    return super.close();
  }
}
