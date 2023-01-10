import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum CalculatorInputType {
  unitPrice,
  downPayment,
  numberOfYears,
  firstDownPayment,
  secondDownPayment,
  thirdDownPayment,
  fourthDownPayment,
}

class CalculatorInputParams extends Equatable {
  final String label;
  final String initialValue;
  final IconData iconData;
  final int maxLength;
  final int minLength;
  final int maxNumOfYears;
  final CalculatorInputType inputType;

  const CalculatorInputParams(
      {required this.label,
      required this.initialValue,
      required this.iconData,
      required this.maxLength,
      required this.minLength,
      required this.inputType,
      this.maxNumOfYears = 30});

  factory CalculatorInputParams.formInputType(CalculatorInputType inputType) {
    switch (inputType) {

      ///TODO add translate
      /// unitPrice
      case CalculatorInputType.unitPrice:
        return CalculatorInputParams(
          label: 'Total Unit Price',
          iconData: Icons.price_change_outlined,
          initialValue: "",
          maxLength: 13,
          minLength: 6,
          inputType: inputType,
        );

      /// downPayment
      case CalculatorInputType.downPayment:
        return CalculatorInputParams(
          label: 'Initial Down payment',
          iconData: Icons.percent_outlined,
          initialValue: "",
          maxLength: 6,
          minLength: 1,
          inputType: inputType,
        );

      /// numberOfYears
      case CalculatorInputType.numberOfYears:
        return CalculatorInputParams(
          label: 'Number of years',
          iconData: Icons.numbers_outlined,
          initialValue: "",
          maxLength: 4,
          minLength: 1,
          inputType: inputType,
        );

      /// firstDownPayment
      case CalculatorInputType.firstDownPayment:
        return CalculatorInputParams(
          label: 'First Down payment',
          iconData: Icons.percent_outlined,
          initialValue: "",
          maxLength: 6,
          minLength: 1,
          inputType: inputType,
        );

      /// secondDownPayment
      case CalculatorInputType.secondDownPayment:
        return CalculatorInputParams(
          label: 'Second Down payment',
          iconData: Icons.percent_outlined,
          initialValue: "",
          maxLength: 6,
          minLength: 1,
          inputType: inputType,
        );

      /// thirdDownPayment
      case CalculatorInputType.thirdDownPayment:
        return CalculatorInputParams(
          label: 'Third Down payment',
          iconData: Icons.percent_outlined,
          initialValue: "",
          maxLength: 6,
          minLength: 1,
          inputType: inputType,
        );

    /// fourthDownPayment
      case CalculatorInputType.fourthDownPayment:
        return CalculatorInputParams(
          label: 'Fourth Down payment',
          iconData: Icons.percent_outlined,
          initialValue: "",
          maxLength: 6,
          minLength: 1,
          inputType: inputType,
        );
    }
  }

  @override
  List<Object?> get props => [
        label,
        initialValue,
        iconData,
        maxLength,
        minLength,
      ];
}
