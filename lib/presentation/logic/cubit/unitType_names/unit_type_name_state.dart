part of 'unit_type_names_cubit.dart';

abstract class UnitTypeNamesState extends Equatable {
  const UnitTypeNamesState();

  @override
  List<Object> get props => [];
}

/// initial
class ResidentialInitial extends UnitTypeNamesState {}


/// loading
class LoadingUnitTypeNames extends UnitTypeNamesState {}

/// empty
class EmptyUnitTypeNames extends UnitTypeNamesState {}


/// fetched
class UnitTypesLoadedState extends UnitTypeNamesState {

  final List<UnitTypeEntity> unitTypes;

  const UnitTypesLoadedState({
    required this.unitTypes,
  });

  @override
  List<Object> get props => [unitTypes];
}

/// error
class ErrorWhileLoadingUnitTypeNames extends UnitTypeNamesState {

  final AppError appError;

  const ErrorWhileLoadingUnitTypeNames({
    required this.appError,
  });
  @override
  List<Object> get props => [appError];
}


