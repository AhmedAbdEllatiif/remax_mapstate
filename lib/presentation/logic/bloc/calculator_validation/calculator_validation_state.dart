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


  /// firstDownPayment
  emptyFirstDownPayment,
  invalidFirstDownPayment,
  maxLengthFirstDownPayment,
  minLengthFirstDownPayment,



  /// secondDownPayment
  emptySecondDownPayment,
  invalidSecondDownPayment,
  maxLengthSecondDownPayment,
  minLengthSecondDownPayment,



  /// thirdDownPayment
  emptyThirdDownPayment,
  invalidThirdDownPayment,
  maxLengthThirdDownPayment,
  minLengthThirdDownPayment,

  successForm,
}

class CalculatorValidationState extends Equatable {
  final CalculatorValidationEnum calculatorValidationEnum;
  final UnitPrice unitPrice;
  final NumberOfYears numberOfYears;
  final DownPaymentForm downPayment;
  final FirstDownPaymentForm firstDownPayment;
  final SecondDownPaymentForm secondDownPayment;
  final ThirdDownPaymentForm thirdDownPayment;
  final int maxLength;
  final int minLength;
  final int unitPriceLength; // the current updated length
  final int downPaymentLength; // the current updated length
  final int numberOfYearsLength; // the current updated length
  final int firstDownPaymentLength; // the current updated length
  final int secondDownPaymentLength; // the current updated length
  final int thirdDownPaymentLength; // the current updated length
  final CalculationFinalResult? calculationFinalResult;

   const CalculatorValidationState( {
    this.unitPrice =  const UnitPrice.dirty(value: ''),
    this.downPayment = const DownPaymentForm.dirty(value: ''),
    this.numberOfYears = const NumberOfYears.dirty(value: ''),
    this.firstDownPayment = const FirstDownPaymentForm.dirty(value: ''),
    this.secondDownPayment = const SecondDownPaymentForm.dirty(value: ''),
    this.thirdDownPayment = const ThirdDownPaymentForm.dirty(value: ''),
     this.maxLength =0,
     this.minLength =0,
     this.unitPriceLength =0,
     this.downPaymentLength =0,
     this.numberOfYearsLength =0,
     this.firstDownPaymentLength =0,
     this.secondDownPaymentLength =0,
     this.thirdDownPaymentLength =0,
    this.calculatorValidationEnum = CalculatorValidationEnum.ideal,
     this.calculationFinalResult,
  });

  CalculatorValidationState copyWith({
    UnitPrice? unitPrice,
    NumberOfYears? numberOfYears,
    DownPaymentForm? downPayment,
    FirstDownPaymentForm? firstDownPaymentForm,
    SecondDownPaymentForm? secondDownPaymentForm,
    ThirdDownPaymentForm? thirdDownPaymentForm,
    CalculatorValidationEnum? validationEnum,
    int? maxLength,
    int? minLength,
    int? unitPriceLength,
    int? downPaymentLength,
    int? numberOfYearsLength,
    CalculationFinalResult? calculationFinalResult,
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
      firstDownPayment: firstDownPaymentForm ?? this.firstDownPayment,
      secondDownPayment: secondDownPaymentForm ?? this.secondDownPayment,
      thirdDownPayment: thirdDownPaymentForm ?? this.thirdDownPayment,
      calculationFinalResult: calculationFinalResult ?? this.calculationFinalResult,
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
    calculationFinalResult,
      ];
}

/*
class CalculatorValidationInitial extends CalculatorValidationState {
  @override
  List<Object> get props => [];
}
*/
