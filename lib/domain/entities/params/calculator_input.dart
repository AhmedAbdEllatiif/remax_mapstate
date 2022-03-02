import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CalculatorInputType { unitPrice, downPayment, numberOfYears }

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
      this.maxNumOfYears = 0});

  factory CalculatorInputParams.formInputType(CalculatorInputType inputType) {
    switch (inputType) {
      case CalculatorInputType.unitPrice:
        return CalculatorInputParams(
          label: 'Unit Price',
          iconData: Icons.price_change_outlined,
          initialValue: "",
          maxLength: 13,
          minLength: 6,
          inputType: inputType,
        );
      case CalculatorInputType.downPayment:
        return CalculatorInputParams(
          label: 'Down payment',
          iconData: Icons.percent_outlined,
          initialValue: "",
          maxLength: 3,
          minLength: 1,
          inputType: inputType,
        );
      case CalculatorInputType.numberOfYears:
        return CalculatorInputParams(
          label: 'Number of years',
          iconData: Icons.numbers_outlined,
          initialValue: "",
          maxLength: 4,
          minLength: 1,
          inputType: inputType,
          maxNumOfYears: 50,
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
