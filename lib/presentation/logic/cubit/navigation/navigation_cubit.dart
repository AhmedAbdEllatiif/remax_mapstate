import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(const HomeState(index: 0));

  void _emitIfNotClosed(NavigationState state) {
    if (!isClosed) {
      emit(state);
    }
  }


  /// To change the current state according to userType and index
  void bottomNavigationPressed(UserType userType, int index){
    switch(index){
      case 0:
        _index0Pressed(userType,index);
        break;
      case 1:
        _index1Pressed(userType,index);
        break;
      case 2:
        _index2Pressed(userType,index);
        break;
      case 3:
        _index3Pressed(userType,index);
        break;
    }
  }


  /// At index 0
  void _index0Pressed(UserType userType, int index) {
    _emitIfNotClosed(
        HomeState(index: index));
  }

  /// At index 1
  void _index1Pressed(UserType userType, int index) {
    ///==> emit support state
    if (userType == UserType.broker || userType == UserType.ambassador) {
      _emitIfNotClosed(
          SupportState(index: index));
    }

    ///==> emit calculator state
    if (userType == UserType.client) {
      _emitIfNotClosed(
          CalculatorState(index: index));
    }

    ///==> emit NotAUser
    if (userType == UserType.tour || userType == UserType.unDefined) {
      _emitIfNotClosed(
          NotAUser(title: TranslateConstants.calculator, index: index));
    }
  }


  /// At index 2
  void _index2Pressed(UserType userType, int index) {
    ///==> emit calculator state
    if (userType == UserType.broker || userType == UserType.ambassador) {
      _emitIfNotClosed(
          CalculatorState(index: index));
    }

    ///==> emit favorite state
    if (userType == UserType.client) {
      _emitIfNotClosed(
          FavoriteState(index: index));
    }

    ///==> emit NotAUser
    if (userType == UserType.tour || userType == UserType.unDefined) {
      _emitIfNotClosed(
          NotAUser(title: TranslateConstants.favorite, index: index));
    }
  }


  /// At index 3
  void _index3Pressed(UserType userType, int index) {
    ///==> emit NotAUser
    if (userType == UserType.tour || userType == UserType.unDefined) {
      _emitIfNotClosed(
          NotAUser(title: TranslateConstants.profile, index: index));
    }

    ///==> emit profile
    else {
      _emitIfNotClosed(
          ProfileState(index: index));
    }
  }
}
