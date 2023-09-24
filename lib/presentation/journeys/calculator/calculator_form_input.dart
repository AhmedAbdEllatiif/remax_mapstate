import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/text_field_calculator.dart';
import 'package:remax_mapstate/presentation/logic/bloc/calculator_validation/calculator_validation_bloc.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../domain/entities/params/calculator_input.dart';
import '../../themes/theme_color.dart';

class CalculatorFormInput extends StatefulWidget {
  final CalculatorInputParams calculatorInputParams;

  const CalculatorFormInput({Key? key, required this.calculatorInputParams})
      : super(key: key);

  @override
  State<CalculatorFormInput> createState() => _CalculatorFormInputState();
}

class _CalculatorFormInputState extends State<CalculatorFormInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorValidationBloc, CalculatorValidationState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// title with icon
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.calculatorInputParams.label,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColor.geeBung, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: Sizes.dimen_10.w,
                ),
                Icon(
                  widget.calculatorInputParams.iconData,
                  color: AppColor.geeBung,
                ),
              ],
            ),

            /// characters count
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                  text: TextSpan(
                text: "(${_getCurrentInputLength(state)}",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColor.white.withOpacity(0.8),
                    ),
                children: [
                  TextSpan(
                    text: " / ${widget.calculatorInputParams.maxLength - 1})",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColor.white.withOpacity(0.8),
                        ),
                  ),
                ],
              )),
            ),

            /// Text field
            TextFieldCalculator(
                calculatorInputParams: widget.calculatorInputParams),

            /// error text
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    right: Sizes.dimen_8.w,
                    left: Sizes.dimen_8.w,
                    top: Sizes.dimen_2.h),
                child: Text(
                  _getError(state.calculatorValidationEnum) ?? "",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.red,
                      ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  int _getCurrentInputLength(CalculatorValidationState state) {
    switch (widget.calculatorInputParams.inputType) {
      case CalculatorInputType.unitPrice:
        return state.unitPriceLength;
      case CalculatorInputType.downPayment:
        return state.downPaymentLength;
      case CalculatorInputType.numberOfYears:
        return state.numberOfYearsLength;

      case CalculatorInputType.firstDownPayment:
        return state.firstDownPaymentLength;
      case CalculatorInputType.secondDownPayment:
        return state.secondDownPaymentLength;
      case CalculatorInputType.thirdDownPayment:
        return state.thirdDownPaymentLength;
      case CalculatorInputType.fourthDownPayment:
        return state.thirdDownPaymentLength;
    }
  }

  String? _getError(CalculatorValidationEnum validationEnum) {
    switch (widget.calculatorInputParams.inputType) {
      /// Unit price
      case CalculatorInputType.unitPrice:
        if (validationEnum == CalculatorValidationEnum.invalidUnitPrice) {
          return (TranslateConstants.invalid.t(context));
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthUnitPrice) {
          return ("${TranslateConstants.atLeast.t(context)} ${widget.calculatorInputParams.minLength} ${TranslateConstants.number.t(context)}");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthUnitPrice) {
          return ("${TranslateConstants.maximumChar.t(context)}  ${widget.calculatorInputParams.maxLength - 1}");
        }
        return null;

      /// Down payment
      case CalculatorInputType.downPayment:
        if (validationEnum == CalculatorValidationEnum.invalidDownPayment) {
          return (TranslateConstants.invalid.t(context));
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthDownPayment) {
          return ("${TranslateConstants.atLeast.t(context)} ${widget.calculatorInputParams.minLength} ${TranslateConstants.number.t(context)}");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthDownPayment) {
          return ("${TranslateConstants.maximumChar.t(context)}  ${widget.calculatorInputParams.maxLength - 1}");
        }
        return null;

      /// Number of years
      case CalculatorInputType.numberOfYears:
        if (validationEnum == CalculatorValidationEnum.largeNumOfYears) {
          return ("[0-${widget.calculatorInputParams.maxNumOfYears}]");
        }
        if (validationEnum == CalculatorValidationEnum.invalidNumberOfYears) {
          return (TranslateConstants.invalid.t(context));
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthNumOfYears) {
          return ("${TranslateConstants.atLeast.t(context)} ${widget.calculatorInputParams.minLength} ${TranslateConstants.number.t(context)}");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthNumOfYears) {
          return ("${TranslateConstants.maximumChar.t(context)} ${widget.calculatorInputParams.maxLength - 1}");
        }
        return null;

      /// First Down payment
      case CalculatorInputType.firstDownPayment:
        if (validationEnum ==
            CalculatorValidationEnum.invalidFirstDownPayment) {
          return (TranslateConstants.invalid.t(context));
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthFirstDownPayment) {
          return ("${TranslateConstants.atLeast.t(context)} ${widget.calculatorInputParams.minLength} ${TranslateConstants.number.t(context)}");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthFirstDownPayment) {
          return ("${TranslateConstants.maximumChar.t(context)} ${widget.calculatorInputParams.maxLength - 1}");
        }
        return null;

      /// Second Down payment
      case CalculatorInputType.secondDownPayment:
        if (validationEnum ==
            CalculatorValidationEnum.invalidSecondDownPayment) {
          return (TranslateConstants.invalid.t(context));
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthSecondDownPayment) {
          return ("${TranslateConstants.atLeast.t(context)} ${widget.calculatorInputParams.minLength} ${TranslateConstants.number.t(context)}");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthSecondDownPayment) {
          return ("${TranslateConstants.maximumChar.t(context)} ${widget.calculatorInputParams.maxLength - 1}");
        }
        return null;

      /// Third Down payment
      case CalculatorInputType.thirdDownPayment:
        if (validationEnum ==
            CalculatorValidationEnum.invalidThirdDownPayment) {
          return (TranslateConstants.invalid.t(context));
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthThirdDownPayment) {
          return ("${TranslateConstants.atLeast.t(context)} ${widget.calculatorInputParams.minLength} ${TranslateConstants.number.t(context)}");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthThirdDownPayment) {
          return ("${TranslateConstants.maximumChar.t(context)} ${widget.calculatorInputParams.maxLength - 1}");
        }
        return null;

      /// Fourth Down payment
      case CalculatorInputType.fourthDownPayment:
        if (validationEnum ==
            CalculatorValidationEnum.invalidFourthDownPayment) {
          return (TranslateConstants.invalid.t(context));
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthFourthDownPayment) {
          return ("${TranslateConstants.atLeast.t(context)} ${widget.calculatorInputParams.minLength} ${TranslateConstants.number.t(context)}");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthFourthDownPayment) {
          return ("${TranslateConstants.maximumChar.t(context)} ${widget.calculatorInputParams.maxLength - 1}");
        }
        return null;

      default:
        return null;
    }
  }
}
