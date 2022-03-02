import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/calculator_form_input.dart';
import 'package:remax_mapstate/presentation/widgets/btn_with_box_shadow.dart';

import '../../../common/constants/sizes.dart';
import '../../../domain/entities/params/calculator_input.dart';
import '../../bloc/calculator_validation/calculator_validation_bloc.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late final CalculatorValidationBloc _calculatorValidationBloc;

  @override
  void initState() {
    super.initState();
    _calculatorValidationBloc = getItInstance<CalculatorValidationBloc>();
  }

  @override
  void dispose() {
    _calculatorValidationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _calculatorValidationBloc,
      child: BlocListener<CalculatorValidationBloc, CalculatorValidationState>(
        listener: (context, state) {
          if (state.calculatorValidationEnum ==
              CalculatorValidationEnum.successForm) {
            print(
                "Success: \n UnitPrice: ${state.unitPrice.value} \n DownPayment: ${state.downPayment.value} \n NumberOfYears: ${state.numberOfYears.value}\n");
          }
        },
        child: Builder(
          builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Sizes.dimen_20.h, horizontal: Sizes.dimen_32.w),
              child: Center(
                child: ListView(
                  children: [
                    /// unitPrice
                     CalculatorFormInput(
                      calculatorInputParams:  CalculatorInputParams.formInputType(CalculatorInputType.unitPrice),
                    ),
                    SizedBox(height: Sizes.dimen_5.h),

                    /// downPayment
                     CalculatorFormInput(
                      calculatorInputParams:  CalculatorInputParams.formInputType(CalculatorInputType.downPayment),
                    ),
                    SizedBox(height: Sizes.dimen_5.h),

                    /// numberOfYears
                     CalculatorFormInput(
                      calculatorInputParams:  CalculatorInputParams.formInputType(CalculatorInputType.numberOfYears),
                    ),
                    SizedBox(height: Sizes.dimen_5.h),

                    /// Button Calculate
                    ButtonWithBoxShadow(
                      text: "Calculate",
                      onPressed: () {
                        context
                            .read<CalculatorValidationBloc>()
                            .add(SubmitCalculatorFormEvent());
                      },
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
