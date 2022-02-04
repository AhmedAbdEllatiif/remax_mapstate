part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();
  @override
  List<Object> get props => ["No State"];
}

class NavigationInitial extends NavigationState {
  @override
  List<Object> get props => ["Initial"];
}


class HomeState extends NavigationState{
  @override
  List<Object> get props => ["Home"];
}

class SupportState extends NavigationState{
   @override
  List<Object> get props => ["Support"];
}

class CalculatorState extends NavigationState{
   @override
  List<Object> get props => ["Calculator"];
}

class FavoriteState extends NavigationState{
   @override
  List<Object> get props => ["Favorite"];
}

class ProfileState extends NavigationState{
   @override
  List<Object> get props => ["Profile"];
}


