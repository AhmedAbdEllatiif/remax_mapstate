part of 'calculator_validation_bloc.dart';

abstract class CalculatorValidationEvent extends Equatable {
  const CalculatorValidationEvent();

  @override
  List<Object?> get props => [];
}

/// UnitPriceChangedEvent
class UnitPriceChangedEvent extends CalculatorValidationEvent {
  final String currentStringOnChange;
  final CalculatorInputParams params;

  const UnitPriceChangedEvent({
    required this.currentStringOnChange,
    required this.params,
  });

  @override
  List<Object?> get props => [currentStringOnChange];
}

/// DownPaymentChangedEvent
class DownPaymentChangedEvent extends CalculatorValidationEvent {
  final String currentStringOnChange;
  final CalculatorInputParams params;

  const DownPaymentChangedEvent({
    required this.currentStringOnChange,
    required this.params,
  });

  @override
  List<Object?> get props => [currentStringOnChange];
}

/// NumberOfYearsChangedEvent
class NumberOfYearsChangedEvent extends CalculatorValidationEvent {
  final String currentStringOnChange;
  final CalculatorInputParams params;

  const NumberOfYearsChangedEvent({
    required this.currentStringOnChange,
    required this.params,
  });

  @override
  List<Object?> get props => [currentStringOnChange];
}



/// FirstDownPaymentChangedEvent
class FirstDownPaymentChangedEvent extends CalculatorValidationEvent {
  final String currentStringOnChange;
  final CalculatorInputParams params;

  const FirstDownPaymentChangedEvent({
    required this.currentStringOnChange,
    required this.params,
  });

  @override
  List<Object?> get props => [currentStringOnChange];
}

/// SecondDownPaymentChangedEvent
class SecondDownPaymentChangedEvent extends CalculatorValidationEvent {
  final String currentStringOnChange;
  final CalculatorInputParams params;

  const SecondDownPaymentChangedEvent({
    required this.currentStringOnChange,
    required this.params,
  });

  @override
  List<Object?> get props => [currentStringOnChange];
}


/// ThirdDownPaymentChangedEvent
class ThirdDownPaymentChangedEvent extends CalculatorValidationEvent {
  final String currentStringOnChange;
  final CalculatorInputParams params;

  const ThirdDownPaymentChangedEvent({
    required this.currentStringOnChange,
    required this.params,
  });

  @override
  List<Object?> get props => [currentStringOnChange];
}

/// FourthDownPaymentChangedEvent
class FourthDownPaymentChangedEvent extends CalculatorValidationEvent {
  final String currentStringOnChange;
  final CalculatorInputParams params;

  const FourthDownPaymentChangedEvent({
    required this.currentStringOnChange,
    required this.params,
  });

  @override
  List<Object?> get props => [currentStringOnChange];
}

/// CalculatorFormSubmitted
class SubmitCalculatorFormEvent extends CalculatorValidationEvent {}
