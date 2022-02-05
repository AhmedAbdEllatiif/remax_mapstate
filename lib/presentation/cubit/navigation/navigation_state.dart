part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  final String title;
  final int index;
  const NavigationState(this.title, this.index);


  @override
  List<Object> get props => [title, index];
}

class HomeState extends NavigationState {
  final String title;
  final int index;

  const HomeState({
    required this.title,
    required this.index,
  }) : super(title, index);

  @override
  List<Object> get props => [title, index];
}

class SupportState extends NavigationState {
  final String title;
  final int index;

  const SupportState({
    required this.title,
    required this.index,
  }) : super(title, index);

  @override
  List<Object> get props => [title, index];
}

class CalculatorState extends NavigationState {
  final String title;
  final int index;

  const CalculatorState({
    required this.title,
    required this.index,
  }) : super(title, index);

  @override
  List<Object> get props => [title, index];
}

class FavoriteState extends NavigationState {
  final String title;
  final int index;

  const FavoriteState({
    required this.title,
    required this.index,
  }) : super(title, index);

  @override
  List<Object> get props => [title, index];
}

class ProfileState extends NavigationState {
  final String title;
  final int index;

  const ProfileState({
    required this.title,
    required this.index,
  }) : super(title, index);

  @override
  List<Object> get props => [title, index];
}
