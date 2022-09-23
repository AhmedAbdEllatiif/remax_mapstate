part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  final String title;
  final int index;
  const NavigationState(this.title, this.index);


  @override
  List<Object> get props => [title, index];
}


/// Home
class HomeState extends NavigationState {
  final int index;

  const HomeState({
    required this.index,
  }) : super(TranslateConstants.home, index);

  @override
  List<Object> get props => [title, index];
}


/// Support
class SupportState extends NavigationState {
  final int index;

  const SupportState({
    required this.index,
  }) : super(TranslateConstants.teamSupport, index);

  @override
  List<Object> get props => [title, index];
}

/// Calculator
class CalculatorState extends NavigationState {
  final int index;

  const CalculatorState({
    required this.index,
  }) : super(TranslateConstants.calculator, index);

  @override
  List<Object> get props => [title, index];
}


/// Favorite
class FavoriteState extends NavigationState {
  final int index;

  const FavoriteState({
    required this.index,
  }) : super(TranslateConstants.favorite, index);

  @override
  List<Object> get props => [title, index];
}


/// Profile
class ProfileState extends NavigationState {
  final int index;

  const ProfileState({
    required this.index,
  }) : super(TranslateConstants.profile, index);

  @override
  List<Object> get props => [title, index];
}


/// NotAUser
class NotAUser extends NavigationState {
  final String title;
  final int index;

  const NotAUser({
    required this.title,
    required this.index,
  }) : super(title, index);

  @override
  List<Object> get props => [title, index];
}
