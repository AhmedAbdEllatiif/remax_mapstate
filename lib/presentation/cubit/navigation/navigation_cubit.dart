import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super( const HomeState(title: TranslateConstants.home, index: 0));

  void home() =>
      emit(const HomeState(title: TranslateConstants.home, index: 0));

  void support() =>
      emit(const SupportState(title: TranslateConstants.support, index: 1));

  void calculator() => emit(
      const CalculatorState(title: TranslateConstants.calculator, index: 2));

  void favorite() =>
      emit(const FavoriteState(title: TranslateConstants.favorite, index: 2));

  void profile() =>
      emit(const ProfileState(title: TranslateConstants.profile, index: 3));
}
