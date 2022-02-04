import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

    void home() => emit(HomeState());
    void support() => emit(SupportState());
    void calculator() => emit(CalculatorState());
    void favorite() => emit(FavoriteState());
    void profile() => emit(ProfileState());

}
