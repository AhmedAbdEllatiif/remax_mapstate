import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/params/calculator_input.dart';
import 'package:remax_mapstate/presentation/journeys/calculation_result/calculation_final_result.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/formz/downpayment.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/formz/number_of_years.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/formz/unit_price.dart';

import '../../../journeys/calculator/formz/first_down_payment.dart';
import '../../../journeys/calculator/formz/fourth_down_payment.dart';
import '../../../journeys/calculator/formz/second_down_payment.dart';
import '../../../journeys/calculator/formz/third_down_payment.dart';

part 'calculator_validation_event.dart';

part 'calculator_validation_state.dart';

class CalculatorValidationBloc
    extends Bloc<CalculatorValidationEvent, CalculatorValidationState> {
  UnitPrice unitPrice;
  NumberOfYears numberOfYears;
  DownPaymentForm downPayment;
  FirstDownPaymentForm firstDownPaymentForm;
  SecondDownPaymentForm secondDownPaymentForm;
  ThirdDownPaymentForm thirdDownPaymentForm;
  FourthDownPaymentForm fourthDownPaymentForm;

  CalculatorValidationBloc(
      {required this.numberOfYears,
      required this.downPayment,
      required this.unitPrice,
      required this.firstDownPaymentForm,
      required this.secondDownPaymentForm,
      required this.thirdDownPaymentForm,
      required this.fourthDownPaymentForm})
      : super(const CalculatorValidationState()) {
    on<CalculatorValidationEvent>((event, emit) {
      //void emitIfNot

      ///************************************* Start of UnitPriceChangedEvent ******************************************************\\
      /// watch on unitPrice changes \\\
      void onUnitPriceChanges(
          UnitPriceChangedEvent event, String unitPriceStr) {
        final maxLength = event.params.maxLength;
        final minLength = event.params.minLength;
        final unitPriceLength = unitPriceStr.length;
        final unitPriceForm = state.unitPrice;
        final isReachedMax = unitPriceStr.length >= maxLength;
        final isNotValid = unitPriceForm.validator(unitPriceStr) != null;

        ///==> maxLength
        if (isReachedMax) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.maxLengthUnitPrice,
              minLength: minLength,
              unitPriceLength: unitPriceLength));
        }

        ///==> validator
        else if (unitPriceStr.isNotEmpty && isNotValid) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.invalidUnitPrice,
              minLength: minLength,
              unitPriceLength: unitPriceLength));
        }

        ///==> else
        else {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.ideal,
              minLength: minLength,
              unitPriceLength: unitPriceLength));
        }
      }

      /// UnitPriceChangedEvent
      if (event is UnitPriceChangedEvent) {
        final unitPriceStr = event.currentStringOnChange.replaceAll(",", '');
        onUnitPriceChanges(event, unitPriceStr);
        unitPrice = UnitPrice.dirty(value: unitPriceStr);
      }

      ///************************************* End of UnitPriceChangedEvent ******************************************************\\

      ///************************************* Start of DownPaymentChangedEvent ******************************************************\\
      /// watch on downPayment changes \\\
      void onDownPaymentChanges(DownPaymentChangedEvent event) {
        final maxLength = event.params.maxLength;
        final minLength = event.params.minLength;
        final currentStr = event.currentStringOnChange;
        final strLength = event.currentStringOnChange.length;
        final downPaymentForm = state.downPayment;
        final isReachedMax = strLength >= maxLength;
        final isNotValid = downPaymentForm.validator(currentStr) != null;
        final lengthOnChanges = event.currentStringOnChange.length;

        ///==> maxLength
        if (isReachedMax) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.maxLengthDownPayment,
              minLength: minLength,
              downPaymentLength: lengthOnChanges));
        }

        ///==> validator
        else if (currentStr.isNotEmpty && isNotValid) {
          if (state.downPayment.error != null) {
            emit(state.copyWith(
                validationEnum: CalculatorValidationEnum.invalidDownPayment,
                minLength: minLength,
                downPaymentLength: lengthOnChanges));
          }
        }

        ///==> else
        else {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.ideal,
              minLength: minLength,
              downPaymentLength: lengthOnChanges));
        }
      }

      /// DownPaymentChangedEvent
      if (event is DownPaymentChangedEvent) {
        onDownPaymentChanges(event);
        downPayment = DownPaymentForm.dirty(value: event.currentStringOnChange);
      }

      ///************************************* End of DownPaymentChangedEvent ******************************************************\\

      ///************************************* Start of NumberOfYearsChangedEvent ******************************************************\\
      /// watch on number of years changes \\\
      void onNumberOfYearsChanges(NumberOfYearsChangedEvent event) {
        final maxLength = event.params.maxLength;
        final minLength = event.params.minLength;
        final currentStr = event.currentStringOnChange;
        final strLength = event.currentStringOnChange.length;
        final numberOfYearsForm = state.numberOfYears;
        final isReachedMax = strLength >= maxLength;
        final isNotValid = numberOfYearsForm.validator(currentStr) != null;
        final lengthOnChanges = event.currentStringOnChange.length;

        ///==> maxLength
        if (isReachedMax) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.maxLengthNumOfYears,
              minLength: minLength,
              numberOfYearsLength: lengthOnChanges));
        }

        ///==> validator
        else if (currentStr.isNotEmpty && isNotValid) {
          if (state.numberOfYears.error != null) {
            emit(state.copyWith(
                validationEnum: CalculatorValidationEnum.invalidNumberOfYears,
                minLength: minLength,
                numberOfYearsLength: lengthOnChanges));
          }
        }

        ///==> check if years more than 50 years
        else if (currentStr.isNotEmpty &&
            double.tryParse(numberOfYears.value) != null) {
          if (double.parse(currentStr) > 50.0) {
            if (state.numberOfYears.error != null) {
              emit(state.copyWith(
                  validationEnum: CalculatorValidationEnum.largeNumOfYears,
                  minLength: minLength,
                  numberOfYearsLength: lengthOnChanges));
            }
          }
        }

        /// else
        else {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.ideal,
              minLength: minLength,
              numberOfYearsLength: lengthOnChanges));
        }
      }

      /// NumberOfYearsChangedEvent
      if (event is NumberOfYearsChangedEvent) {
        onNumberOfYearsChanges(event);
        numberOfYears = NumberOfYears.dirty(value: event.currentStringOnChange);
      }

      ///************************************* End of NumberOfYearsChangedEvent ******************************************************\\

      ///************************************* Start first of DownPaymentChangedEvent ******************************************************\\
      /// watch on firstDownPayment changes \\\
      void onFirstDownPaymentChanges(FirstDownPaymentChangedEvent event) {
        final maxLength = event.params.maxLength;
        final minLength = event.params.minLength;
        final currentStr = event.currentStringOnChange;
        final strLength = event.currentStringOnChange.length;
        final downPaymentForm = state.downPayment;
        final isReachedMax = strLength >= maxLength;
        final isNotValid = downPaymentForm.validator(currentStr) != null;
        final lengthOnChanges = event.currentStringOnChange.length;

        ///==> maxLength
        if (isReachedMax) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.maxLengthFirstDownPayment,
              minLength: minLength,
              downPaymentLength: lengthOnChanges));
        }

        ///==> validator
        else if (currentStr.isNotEmpty && isNotValid) {
          if (state.firstDownPayment.error != null) {
            emit(state.copyWith(
                validationEnum:
                    CalculatorValidationEnum.invalidFirstDownPayment,
                minLength: minLength,
                downPaymentLength: lengthOnChanges));
          }
        }

        ///==> else
        else {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.ideal,
              minLength: minLength,
              downPaymentLength: lengthOnChanges));
        }
      }

      /// FirstDownPaymentChangedEvent
      if (event is FirstDownPaymentChangedEvent) {
        onFirstDownPaymentChanges(event);
        firstDownPaymentForm =
            FirstDownPaymentForm.dirty(value: event.currentStringOnChange);
      }

      ///************************************* End first of DownPaymentChangedEvent ******************************************************\\

      ///************************************* Start second of DownPaymentChangedEvent ******************************************************\\
      /// watch on secondDownPayment changes \\\
      void onSecondDownPaymentChanges(SecondDownPaymentChangedEvent event) {
        final maxLength = event.params.maxLength;
        final minLength = event.params.minLength;
        final currentStr = event.currentStringOnChange;
        final strLength = event.currentStringOnChange.length;
        final downPaymentForm = state.downPayment;
        final isReachedMax = strLength >= maxLength;
        final isNotValid = downPaymentForm.validator(currentStr) != null;
        final lengthOnChanges = event.currentStringOnChange.length;

        ///==> maxLength
        if (isReachedMax) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.maxLengthSecondDownPayment,
              minLength: minLength,
              downPaymentLength: lengthOnChanges));
        }

        ///==> validator
        else if (currentStr.isNotEmpty && isNotValid) {
          if (state.secondDownPayment.error != null) {
            emit(state.copyWith(
                validationEnum:
                    CalculatorValidationEnum.invalidSecondDownPayment,
                minLength: minLength,
                downPaymentLength: lengthOnChanges));
          }
        }

        ///==> else
        else {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.ideal,
              minLength: minLength,
              downPaymentLength: lengthOnChanges));
        }
      }

      /// SecondDownPaymentChangedEvent
      if (event is SecondDownPaymentChangedEvent) {
        onSecondDownPaymentChanges(event);
        secondDownPaymentForm =
            SecondDownPaymentForm.dirty(value: event.currentStringOnChange);
      }

      ///************************************* End second of DownPaymentChangedEvent ******************************************************\\

      ///************************************* Start third of DownPaymentChangedEvent ******************************************************\\
      /// watch on thirdDownPayment changes \\\
      void onThirdDownPaymentChanges(ThirdDownPaymentChangedEvent event) {
        final maxLength = event.params.maxLength;
        final minLength = event.params.minLength;
        final currentStr = event.currentStringOnChange;
        final strLength = event.currentStringOnChange.length;
        final downPaymentForm = state.downPayment;
        final isReachedMax = strLength >= maxLength;
        final isNotValid = downPaymentForm.validator(currentStr) != null;
        final lengthOnChanges = event.currentStringOnChange.length;

        ///==> maxLength
        if (isReachedMax) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.maxLengthThirdDownPayment,
              minLength: minLength,
              downPaymentLength: lengthOnChanges));
        }

        ///==> validator
        else if (currentStr.isNotEmpty && isNotValid) {
          if (state.thirdDownPayment.error != null) {
            emit(state.copyWith(
                validationEnum:
                    CalculatorValidationEnum.invalidThirdDownPayment,
                minLength: minLength,
                downPaymentLength: lengthOnChanges));
          }
        }

        ///==> else
        else {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.ideal,
              minLength: minLength,
              downPaymentLength: lengthOnChanges));
        }
      }

      /// ThirdDownPaymentChangedEvent
      if (event is ThirdDownPaymentChangedEvent) {
        onThirdDownPaymentChanges(event);
        thirdDownPaymentForm =
            ThirdDownPaymentForm.dirty(value: event.currentStringOnChange);
      }

      ///************************************* End third of DownPaymentChangedEvent ******************************************************\\

      ///************************************* Start fourth of DownPaymentChangedEvent ******************************************************\\
      /// watch on fourthDownPayment changes \\\
      void onFourthDownPaymentChanges(FourthDownPaymentChangedEvent event) {
        final maxLength = event.params.maxLength;
        final minLength = event.params.minLength;
        final currentStr = event.currentStringOnChange;
        final strLength = event.currentStringOnChange.length;
        final downPaymentForm = state.downPayment;
        final isReachedMax = strLength >= maxLength;
        final isNotValid = downPaymentForm.validator(currentStr) != null;
        final lengthOnChanges = event.currentStringOnChange.length;

        ///==> maxLength
        if (isReachedMax) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.maxLengthFourthDownPayment,
              minLength: minLength,
              downPaymentLength: lengthOnChanges));
        }

        ///==> validator
        else if (currentStr.isNotEmpty && isNotValid) {
          if (state.fourthDownPaymentForm.error != null) {
            emit(state.copyWith(
                validationEnum:
                    CalculatorValidationEnum.invalidFourthDownPayment,
                minLength: minLength,
                downPaymentLength: lengthOnChanges));
          }
        }

        ///==> else
        else {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.ideal,
              minLength: minLength,
              downPaymentLength: lengthOnChanges));
        }
      }

      /// FourthDownPaymentChangedEvent
      if (event is FourthDownPaymentChangedEvent) {
        onFourthDownPaymentChanges(event);
        fourthDownPaymentForm =
            FourthDownPaymentForm.dirty(value: event.currentStringOnChange);
      }

      ///************************************* End third of DownPaymentChangedEvent ******************************************************\\

      ///************************************* Submit ******************************************************\\
      /// CalculatorFormSubmitted
      if (event is SubmitCalculatorFormEvent) {
        ///==> unitPrice is invalid
        if (unitPrice.value.length < 6) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.minLengthUnitPrice));
        } else if (unitPrice.value.length >= 13) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.maxLengthUnitPrice));
        } else if (unitPrice.invalid) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.invalidUnitPrice));
        }

        ///==> downPayment is invalid
        else if (downPayment.value.isEmpty) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.minLengthDownPayment));
        } else if (downPayment.value.length >= 6) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.maxLengthDownPayment));
        } else if (downPayment.invalid) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.invalidDownPayment));
        }

        ///==> numberOfYears is invalid
        else if (numberOfYears.value.isEmpty) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.minLengthNumOfYears));
        } else if (numberOfYears.value.length >= 4) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.maxLengthNumOfYears));
        } else if (double.tryParse(numberOfYears.value) == null) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.invalidNumberOfYears));
        } else if (double.parse(numberOfYears.value) > 50.0) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.largeNumOfYears));
        } else if (numberOfYears.invalid) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.invalidNumberOfYears));
        }

        ///==> firstDownPayment is invalid
        // else if (firstDownPaymentForm.value.isEmpty) {
        //   emit(state.copyWith(
        //       validationEnum:
        //           CalculatorValidationEnum.minLengthFirstDownPayment));
        // }

        else if (firstDownPaymentForm.value.length >= 6) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.maxLengthFirstDownPayment));
        } else if (firstDownPaymentForm.invalid) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.invalidFirstDownPayment));
        }

        ///==> secondDownPayment is invalid
        // else if (secondDownPaymentForm.value.isEmpty) {
        //   emit(state.copyWith(
        //       validationEnum:
        //           CalculatorValidationEnum.minLengthSecondDownPayment));
        // }
        else if (secondDownPaymentForm.value.isNotEmpty &&
            firstDownPaymentForm.value.isEmpty) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.minLengthFirstDownPayment));
        } else if (secondDownPaymentForm.value.length >= 6) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.maxLengthSecondDownPayment));
        } else if (secondDownPaymentForm.invalid) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.invalidSecondDownPayment));
        }

        ///==> thirdDownPayment is invalid
        // else if (thirdDownPaymentForm.value.isEmpty) {
        //   emit(state.copyWith(
        //       validationEnum:
        //           CalculatorValidationEnum.minLengthThirdDownPayment));
        // }

        else if (thirdDownPaymentForm.value.isNotEmpty &&
            secondDownPaymentForm.value.isEmpty) {
          emit(state.copyWith(
              validationEnum:
              CalculatorValidationEnum.minLengthSecondDownPayment));
        }else if (thirdDownPaymentForm.value.length >= 6) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.maxLengthThirdDownPayment));
        } else if (thirdDownPaymentForm.invalid) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.invalidThirdDownPayment));
        }

        ///==> fourthDownPaymentForm is invalid
        // else if (fourthDownPaymentForm.value.isEmpty) {
        //   emit(state.copyWith(
        //       validationEnum:
        //           CalculatorValidationEnum.minLengthFourthDownPayment));
        // }

        else if (fourthDownPaymentForm.value.isNotEmpty &&
            thirdDownPaymentForm.value.isEmpty) {
          emit(state.copyWith(
              validationEnum:
              CalculatorValidationEnum.minLengthThirdDownPayment));
        } else if (fourthDownPaymentForm.value.length >= 6) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.maxLengthFourthDownPayment));
        } else if (fourthDownPaymentForm.invalid) {
          emit(state.copyWith(
              validationEnum:
                  CalculatorValidationEnum.invalidFourthDownPayment));
        }

        /// else All valid
        else {
          final double totalUnitPrice = double.parse(unitPrice.value);
          final double totalNumberOfYears = double.parse(numberOfYears.value);
          final double initialDownPayment = double.parse(downPayment.value);
          final double? firstDownPayment =
              double.tryParse(firstDownPaymentForm.value);
          final double? secondDownPayment =
              double.tryParse(secondDownPaymentForm.value);
          final double? thirdDownPayment =
              double.tryParse(thirdDownPaymentForm.value);
          final double? fourthDownPayment =
              double.tryParse(fourthDownPaymentForm.value);
          emit(state.copyWith(
            calculationFinalResult: CalculationFinalResult.calculate(
                totalUnitPrice: totalUnitPrice,
                initialDownPayment: initialDownPayment,
                numOfYears: totalNumberOfYears,
                firstDownPayment: firstDownPayment ?? 0,
                secondDownPayment: secondDownPayment ?? 0,
                thirdDownPayment: thirdDownPayment ?? 0,
                fourthDownPayment: fourthDownPayment ?? 0),
            validationEnum: CalculatorValidationEnum.successForm,
          ));
        }
      }
    });
  }
}
