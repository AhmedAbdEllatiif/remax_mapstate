import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/presentation/journeys/calculation_result/calculation_result_item.dart';

import 'package:intl/intl.dart';

import '../../logic/bloc/calculator_validation/calculator_validation_bloc.dart';

class CalculationResultScreen extends StatelessWidget {

  final CalculatorValidationBloc calculatorValidationBloc;


   CalculationResultScreen({Key? key, required this.calculatorValidationBloc}) : super(key: key);
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
          if(state.calculatorValidationEnum == CalculatorValidationEnum.successForm){
            if(state.calculationFinalResult != null){
              return ListView(
                children: [

                  /// Initial downPayment
                  CalculationResultItem(label: "Initial DownPayment",result: state.calculationFinalResult!.initialDownPaymentResult),
                  CalculationResultItem(label: "First DownPayment",result: state.calculationFinalResult!.firstDownPaymentResult),
                  CalculationResultItem(label: "Second DownPayment",result: state.calculationFinalResult!.secondDownPaymentResult),
                  CalculationResultItem(label: "Third DownPayment",result: state.calculationFinalResult!.thirdDownPaymentResult),
                  CalculationResultItem(label: "Fourth DownPayment",result: state.calculationFinalResult!.thirdDownPaymentResult),
                  CalculationResultItem(label: "Monthly Installment",result: state.calculationFinalResult!.monthlyInstallment),
                  CalculationResultItem(label: "Quarterly Installment",result: state.calculationFinalResult!.quarterlyInstallment),
                ],
              );
            }

            return const Center(
              child: Text("No result available calculationFinalResult is null value"),
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
