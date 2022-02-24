import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(const HomeState(title: TranslateConstants.home, index: 0));

  void _emitIfNotClosed(NavigationState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  void home(int index) =>
      _emitIfNotClosed(HomeState(title: TranslateConstants.home, index: index));

  void support(int index) => _emitIfNotClosed(
      SupportState(title: TranslateConstants.support, index: index));

  void calculator(int index) => _emitIfNotClosed(
      CalculatorState(title: TranslateConstants.calculator, index: index));

  void favorite(int index) => _emitIfNotClosed(
      FavoriteState(title: TranslateConstants.favorite, index: index));

  void profile(int index) => _emitIfNotClosed(
      ProfileState(title: TranslateConstants.profile, index: index));
}
