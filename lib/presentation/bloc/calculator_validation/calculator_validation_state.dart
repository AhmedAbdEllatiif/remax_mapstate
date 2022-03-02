part of 'calculator_validation_bloc.dart';

enum CalculatorValidationEnum {
  ideal,


  /// UnitPrice
  emptyUnitPrice,
  invalidUnitPrice,
  maxLengthUnitPrice,
  minLengthUnitPrice,


  /// DownPayment
  emptyDownPayment,
  invalidDownPayment,
  maxLengthDownPayment,
  minLengthDownPayment,

  /// NumberOfYears
  emptyNumberOfYears,
  largeNumOfYears,
  invalidNumberOfYears,
  maxLengthNumOfYears,
  minLengthNumOfYears,

  successForm,
}

class CalculatorValidationState extends Equatable {
  final CalculatorValidationEnum calculatorValidationEnum;
  final UnitPrice unitPrice;
  final NumberOfYears numberOfYears;
  final DownPaymentForm downPayment;
  final int maxLength;
  final int minLength;
  final int unitPriceLength; // the current updated lenght
  final int downPaymentLength; // the current updated lenght
  final int numberOfYearsLength; // the current updated lenght

   const CalculatorValidationState({
    this.unitPrice =  const UnitPrice.dirty(value: ''),
    this.downPayment = const DownPaymentForm.dirty(value: ''),
    this.numberOfYears = const NumberOfYears.dirty(value: ''),
     this.maxLength =0,
     this.minLength =0,
     this.unitPriceLength =0,
     this.downPaymentLength =0,
     this.numberOfYearsLength =0,
    this.calculatorValidationEnum = CalculatorValidationEnum.ideal,
  });

  CalculatorValidationState copyWith({
    UnitPrice? unitPrice,
    NumberOfYears? numberOfYears,
    DownPaymentForm? downPayment,
    CalculatorValidationEnum? validationEnum,
    int? maxLength,
    int? minLength,
    int? unitPriceLength,
    int? downPaymentLength,
    int? numberOfYearsLength,
  }) {
    return CalculatorValidationState(
      unitPrice: unitPrice ?? this.unitPrice,
      numberOfYears: numberOfYears ?? this.numberOfYears,
      downPayment: downPayment ?? this.downPayment,
      calculatorValidationEnum:
          validationEnum ?? calculatorValidationEnum,
      minLength: minLength?? this.minLength,
        maxLength: maxLength?? this.maxLength,
      unitPriceLength: unitPriceLength?? this.unitPriceLength,
      downPaymentLength: downPaymentLength?? this.downPaymentLength,
      numberOfYearsLength: numberOfYearsLength?? this.numberOfYearsLength,
    );
  }

  @override
  List<Object?> get props => [
    unitPrice,
    numberOfYears,
    downPayment,
    calculatorValidationEnum,
    maxLength,
    minLength,
    unitPriceLength,
    downPaymentLength,
    numberOfYearsLength,
      ];
}

/*
class CalculatorValidationInitial extends CalculatorValidationState {
  @override
  List<Object> get props => [];
}
*/
