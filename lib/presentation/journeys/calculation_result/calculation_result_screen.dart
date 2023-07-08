import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/calculation_result/calculation_result_item.dart';

import 'package:intl/intl.dart';

import '../../logic/bloc/calculator_validation/calculator_validation_bloc.dart';

class CalculationResultScreen extends StatelessWidget {
  final CalculatorValidationBloc calculatorValidationBloc;

  CalculationResultScreen({Key? key, required this.calculatorValidationBloc})
      : super(key: key);
  NumberFormat numberFormat = NumberFormat.decimalPattern('hi');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculation Result"),
      ),
      body: BlocBuilder<CalculatorValidationBloc, CalculatorValidationState>(
        bloc: calculatorValidationBloc,
        builder: (context, state) {
          if (state.calculatorValidationEnum ==
              CalculatorValidationEnum.successForm) {
            if (state.calculationFinalResult != null) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_10.w),
                children: [
                  /// Initial downPayment
                  CalculationResultItem(
                      label: "Initial DownPayment",
                      result: state
                          .calculationFinalResult!.initialDownPaymentResult),
                  state.calculationFinalResult!.firstDownPaymentResult == "000"
                      ? const SizedBox.shrink()
                      : CalculationResultItem(
                          label: "First DownPayment",
                          result: state
                              .calculationFinalResult!.firstDownPaymentResult),


                  state.calculationFinalResult!.secondDownPaymentResult == "000"
                      ? const SizedBox.shrink()
                      :  CalculationResultItem(
                      label: "Second DownPayment",
                      result: state
                          .calculationFinalResult!.secondDownPaymentResult),


                  state.calculationFinalResult!.thirdDownPaymentResult == "000"
                      ? const SizedBox.shrink()
                      : CalculationResultItem(
                      label: "Third DownPayment",
                      result:
                          state.calculationFinalResult!.thirdDownPaymentResult),


                  state.calculationFinalResult!.fourthDownPaymentResult == "000"
                      ? const SizedBox.shrink()
                      :  CalculationResultItem(
                      label: "Fourth DownPayment",
                      result:
                          state.calculationFinalResult!.thirdDownPaymentResult),
                  CalculationResultItem(
                      label: "Monthly Installment",
                      result: state.calculationFinalResult!.monthlyInstallment),
                  CalculationResultItem(
                      label: "Quarterly Installment",
                      result:
                          state.calculationFinalResult!.quarterlyInstallment),
                ],
              );
            }

            return const Center(
              child: Text(
                  "No result available calculationFinalResult is null value"),
            );
          }
          return const Center(
            child: Text("No result available"),
          );
        },
      ),
    );
  }
}
