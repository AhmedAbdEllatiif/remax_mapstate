import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/calculator_form_input.dart';
import 'package:remax_mapstate/presentation/widgets/btn_with_box_shadow.dart';

import '../../../common/constants/sizes.dart';
import '../../../domain/entities/params/calculator_input.dart';
import '../../../router/route_hepler.dart';
import '../../bloc/calculator_validation/calculator_validation_bloc.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late final CalculatorValidationBloc _calculatorValidationBloc;
  final unitTypeKey = GlobalKey();
  final downPaymentKey = GlobalKey();
  final numberOfYearsKey = GlobalKey();
  final firstDownPaymentKey = GlobalKey();
  final secondDownPaymentKey = GlobalKey();
  final thirdDownPaymentKey = GlobalKey();

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

  bool canNavigate = false;

  void _navigateToCalculationResultScreen(CalculatorValidationState state) {
    if (state.calculatorValidationEnum ==
        CalculatorValidationEnum.successForm) {
      RouteHelper().calculationResultScreen(context,_calculatorValidationBloc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _calculatorValidationBloc,
      child: BlocListener<CalculatorValidationBloc, CalculatorValidationState>(
        listener: (context, state) {
          _moveToErrorPosition(state.calculatorValidationEnum);

          if (state.calculatorValidationEnum ==
              CalculatorValidationEnum.successForm) {
            /// navigate to CalculationScreen result
            _navigateToCalculationResultScreen(state);
            /* print("Success: \n "
                "UnitPrice: ${state.unitPrice.value} \n "
                "DownPayment: ${state.downPayment.value} \n "
                "NumberOfYears: ${state.numberOfYears.value}\n "
                "FirstDownPayment: ${state.firstDownPayment.value}\n "
                "SecondDownPayment: ${state.secondDownPayment.value}\n "
                "ThirdDownPayment: ${state.thirdDownPayment.value}\n");*/
          }
        },
        child: Builder(builder: (context) {
          return Scrollbar(
            child: Padding(
              padding: EdgeInsets.only(
                  top: Sizes.dimen_10.h,
                  left: Sizes.dimen_32.w,
                  right: Sizes.dimen_32.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// unitPrice
                    CalculatorFormInput(
                      key: unitTypeKey,
                      calculatorInputParams:
                          CalculatorInputParams.formInputType(
                              CalculatorInputType.unitPrice),
                    ),
                    SizedBox(height: Sizes.dimen_5.h),

                    /// downPayment
                    CalculatorFormInput(
                      key: downPaymentKey,
                      calculatorInputParams:
                          CalculatorInputParams.formInputType(
                              CalculatorInputType.downPayment),
                    ),
                    SizedBox(height: Sizes.dimen_5.h),

                    /// numberOfYears
                    CalculatorFormInput(
                      key: numberOfYearsKey,
                      calculatorInputParams:
                          CalculatorInputParams.formInputType(
                              CalculatorInputType.numberOfYears),
                    ),
                    SizedBox(height: Sizes.dimen_5.h),

                    /// firstDownPayment
                    CalculatorFormInput(
                      key: firstDownPaymentKey,
                      calculatorInputParams:
                          CalculatorInputParams.formInputType(
                              CalculatorInputType.firstDownPayment),
                    ),
                    SizedBox(height: Sizes.dimen_5.h),

                    /// secondDownPayment
                    CalculatorFormInput(
                      key: secondDownPaymentKey,
                      calculatorInputParams:
                          CalculatorInputParams.formInputType(
                              CalculatorInputType.secondDownPayment),
                    ),
                    SizedBox(height: Sizes.dimen_5.h),

                    /// thirdDownPayment
                    CalculatorFormInput(
                      key: thirdDownPaymentKey,
                      calculatorInputParams:
                          CalculatorInputParams.formInputType(
                              CalculatorInputType.thirdDownPayment),
                    ),
                    SizedBox(height: Sizes.dimen_5.h),

                    /// Button Calculate
                    ButtonWithBoxShadow(
                      text: "Calculate",
                      onPressed: () {
                        context
                            .read<CalculatorValidationBloc>()
                            .add(SubmitCalculatorFormEvent());

                        _navigateToCalculationResultScreen(
                            context.read<CalculatorValidationBloc>().state);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// To move to the error position
  void _moveToErrorPosition(CalculatorValidationEnum calculatorValidationEnum) {
    /// current global key
    GlobalKey currentKey = GlobalKey();

    switch (calculatorValidationEnum) {
      case CalculatorValidationEnum.ideal:
      case CalculatorValidationEnum.successForm:
        return;

      /// UnitPrice
      case CalculatorValidationEnum.emptyUnitPrice:
      case CalculatorValidationEnum.invalidUnitPrice:
      case CalculatorValidationEnum.maxLengthUnitPrice:
      case CalculatorValidationEnum.minLengthUnitPrice:
        currentKey = unitTypeKey;
        break;

      /// emptyDownPayment
      case CalculatorValidationEnum.emptyDownPayment:
      case CalculatorValidationEnum.invalidDownPayment:
      case CalculatorValidationEnum.maxLengthDownPayment:
      case CalculatorValidationEnum.minLengthDownPayment:
        currentKey = downPaymentKey;
        break;

      /// emptyNumberOfYears
      case CalculatorValidationEnum.emptyNumberOfYears:
      case CalculatorValidationEnum.largeNumOfYears:
      case CalculatorValidationEnum.invalidNumberOfYears:
      case CalculatorValidationEnum.maxLengthNumOfYears:
      case CalculatorValidationEnum.minLengthNumOfYears:
        currentKey = numberOfYearsKey;
        break;

      /// FirstDownPayment
      case CalculatorValidationEnum.emptyFirstDownPayment:
      case CalculatorValidationEnum.invalidFirstDownPayment:
      case CalculatorValidationEnum.maxLengthFirstDownPayment:
      case CalculatorValidationEnum.minLengthFirstDownPayment:
        currentKey = firstDownPaymentKey;
        break;

      ///SecondDownPayment
      case CalculatorValidationEnum.emptySecondDownPayment:
      case CalculatorValidationEnum.invalidSecondDownPayment:
      case CalculatorValidationEnum.maxLengthSecondDownPayment:
      case CalculatorValidationEnum.minLengthSecondDownPayment:
        currentKey = secondDownPaymentKey;
        break;

      /// ThirdDownPayment
      case CalculatorValidationEnum.emptyThirdDownPayment:
      case CalculatorValidationEnum.invalidThirdDownPayment:
      case CalculatorValidationEnum.maxLengthThirdDownPayment:
      case CalculatorValidationEnum.minLengthThirdDownPayment:
        currentKey = thirdDownPaymentKey;
        break;
    }

    /// scroll to error position
    if (currentKey.currentContext != null) {
      Scrollable.ensureVisible(
        currentKey.currentContext!,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
