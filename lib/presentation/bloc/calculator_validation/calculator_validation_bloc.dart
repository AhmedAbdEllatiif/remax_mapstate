import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/params/calculator_input.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/formz/downpayment.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/formz/number_of_years.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/formz/unit_price.dart';

part 'calculator_validation_event.dart';

part 'calculator_validation_state.dart';

class CalculatorValidationBloc
    extends Bloc<CalculatorValidationEvent, CalculatorValidationState> {
  UnitPrice unitPrice;
  NumberOfYears numberOfYears;
  DownPaymentForm downPayment;

  CalculatorValidationBloc(
      {required this.numberOfYears,
      required this.downPayment,
      required this.unitPrice})
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
        else if( double.tryParse(numberOfYears.value) == null){
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.invalidNumberOfYears));
        }

        ///==> check if years more than 50 years
        else if (double.parse(currentStr) > 50.0) {
          if (state.numberOfYears.error != null) {
            emit(state.copyWith(
                validationEnum: CalculatorValidationEnum.largeNumOfYears,
                minLength: minLength,
                numberOfYearsLength: lengthOnChanges));
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

      ///************************************* Submit ******************************************************\\
      /// CalculatorFormSubmitted
      if (event is SubmitCalculatorFormEvent) {
        ///==> unitPrice is invalid
        if (unitPrice.value.length < 6) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.minLengthUnitPrice));
        }
        else if (unitPrice.value.length >= 13) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.maxLengthUnitPrice));
        }
        else if (unitPrice.invalid) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.invalidUnitPrice));
        }

        ///==> downPayment is invalid
        else if (downPayment.value.isEmpty) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.minLengthDownPayment));
        }else if (downPayment.value.length >= 3) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.maxLengthDownPayment));
        }
        else if (downPayment.invalid) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.invalidDownPayment));
        }

        ///==> numberOfYears is invalid
        else if (numberOfYears.value.isEmpty) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.minLengthNumOfYears));
        }
        else if (downPayment.value.length >= 4) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.maxLengthNumOfYears));
        }
        else if( double.tryParse(numberOfYears.value) == null){
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.invalidNumberOfYears));
        }
        else if (double.parse(numberOfYears.value) > 50.0) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.largeNumOfYears));
        }
        else if (numberOfYears.invalid) {
          emit(state.copyWith(
              validationEnum: CalculatorValidationEnum.invalidNumberOfYears));
        }

        /// else All valid
        else {
          emit(state.copyWith(
            unitPrice: unitPrice,
            numberOfYears: numberOfYears,
            downPayment: downPayment,
            validationEnum: CalculatorValidationEnum.successForm,
          ));
        }
      }
    });
  }
}
