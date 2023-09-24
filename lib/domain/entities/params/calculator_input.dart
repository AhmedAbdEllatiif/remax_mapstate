import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

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

  factory CalculatorInputParams.formInputType(BuildContext context,CalculatorInputType inputType) {
    switch (inputType) {

      ///TODO add translate
      /// unitPrice
      case CalculatorInputType.unitPrice:
        return CalculatorInputParams(

          label: TranslateConstants.totalUnitPrice.t(context),
          iconData: Icons.price_change_outlined,
          initialValue: "",
          maxLength: 13,
          minLength: 6,
          inputType: inputType,
        );

      /// downPayment
      case CalculatorInputType.downPayment:
        return CalculatorInputParams(

          label:  TranslateConstants.initialDownPayment.t(context),
          iconData: Icons.percent_outlined,
          initialValue: "",
          maxLength: 6,
          minLength: 1,
          inputType: inputType,
        );

      /// numberOfYears
      case CalculatorInputType.numberOfYears:
        return CalculatorInputParams(
          label: TranslateConstants.numberOfYearsFull.t(context),
          iconData: Icons.numbers_outlined,
          initialValue: "",
          maxLength: 4,
          minLength: 1,
          inputType: inputType,
        );

      /// firstDownPayment
      case CalculatorInputType.firstDownPayment:
        return CalculatorInputParams(
          label: TranslateConstants.firstDownPayment.t(context),
          iconData: Icons.percent_outlined,
          initialValue: "",
          maxLength: 6,
          minLength: 1,
          inputType: inputType,
        );

      /// secondDownPayment
      case CalculatorInputType.secondDownPayment:
        return CalculatorInputParams(
          label: TranslateConstants.secondDownPayment.t(context),
          iconData: Icons.percent_outlined,
          initialValue: "",
          maxLength: 6,
          minLength: 1,
          inputType: inputType,
        );

      /// thirdDownPayment
      case CalculatorInputType.thirdDownPayment:
        return CalculatorInputParams(
          label: TranslateConstants.thirdDownPayment.t(context),
          iconData: Icons.percent_outlined,
          initialValue: "",
          maxLength: 6,
          minLength: 1,
          inputType: inputType,
        );

    /// fourthDownPayment
      case CalculatorInputType.fourthDownPayment:
        return CalculatorInputParams(
          label: TranslateConstants.fourthDownPayment.t(context),
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
