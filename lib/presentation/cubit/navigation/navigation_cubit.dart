import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super( const HomeState(title: TranslateConstants.home, index: 0));

  void home(int index) =>
      emit(HomeState(title: TranslateConstants.home, index: index));

  void support(int index) =>
      emit(SupportState(title: TranslateConstants.support, index: index));

  void calculator(int index) => emit(
      CalculatorState(title: TranslateConstants.calculator, index: index));

  void favorite(int index) =>
      emit(FavoriteState(title: TranslateConstants.favorite, index: index));

  void profile(int index) =>
      emit(ProfileState(title: TranslateConstants.profile, index: index));
}
