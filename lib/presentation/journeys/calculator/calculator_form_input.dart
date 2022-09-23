import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/calculator/text_field_calculator.dart';
import 'package:remax_mapstate/presentation/logic/bloc/calculator_validation/calculator_validation_bloc.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../domain/entities/params/calculator_input.dart';
import '../../themes/theme_color.dart';

class CalculatorFormInput extends StatelessWidget {
  final CalculatorInputParams calculatorInputParams;

  const CalculatorFormInput({Key? key, required this.calculatorInputParams})
      : super(key: key);

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
                  calculatorInputParams.label,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: AppColor.absoluteTransparentGeeBung, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: Sizes.dimen_10.w,
                ),
                Icon(calculatorInputParams.iconData,color: AppColor.absoluteTransparentGeeBung,),
              ],
            ),

            /// characters count
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                  text: TextSpan(
                text: "(${_getCurrentInputLength(state)}",
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: AppColor.absoluteTransparentGeeBung,
                    ),
                children: [
                  TextSpan(
                    text: " / ${calculatorInputParams.maxLength - 1})",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: AppColor.absoluteTransparentGeeBung,
                        ),
                  ),
                ],
              )),
            ),

            /// Text field
            TextFieldCalculator(calculatorInputParams: calculatorInputParams),

            /// error text
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(right: Sizes.dimen_8.w,left: Sizes.dimen_8.w,top: Sizes.dimen_2.h),
                child: Text(
                  _getError(state.calculatorValidationEnum) ?? "",
                  style: Theme.of(context).textTheme.caption!.copyWith(
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
    switch (calculatorInputParams.inputType) {
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
    }
  }

  String? _getError(CalculatorValidationEnum validationEnum) {
    switch (calculatorInputParams.inputType) {

      /// Unit price
      case CalculatorInputType.unitPrice:
         if (validationEnum ==
            CalculatorValidationEnum.invalidUnitPrice) {
          return ("* Invalid Unit Price");
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthUnitPrice) {
          return ("* Unit Price should contain at least ${calculatorInputParams.minLength} characters");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthUnitPrice) {
          return ("* Unit Price maximum characters is ${calculatorInputParams.maxLength - 1}");
        }
        return null;

      /// Down payment
      case CalculatorInputType.downPayment:
          if (validationEnum ==
            CalculatorValidationEnum.invalidDownPayment) {
          return ("* Invalid DownPayment");
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthDownPayment) {
          return ("* Down payment should contain at least ${calculatorInputParams.minLength} characters");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthDownPayment) {
          return ("* Down payment maximum characters is ${calculatorInputParams.maxLength - 1}");
        }
        return null;

      /// Number of years
      case CalculatorInputType.numberOfYears:
        if (validationEnum ==
            CalculatorValidationEnum.largeNumOfYears) {
          return ("* Large number of years must be [0-${calculatorInputParams.maxNumOfYears}]");
        }
        if (validationEnum ==
            CalculatorValidationEnum.invalidNumberOfYears) {
          return ("* Invalid number of years");
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthNumOfYears) {
          return ("* Number of years should contain at least ${calculatorInputParams.minLength} characters");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthNumOfYears) {
          return ("* Number of years maximum characters is ${calculatorInputParams.maxLength - 1}");
        }
        return null;


    /// First Down payment
      case CalculatorInputType.firstDownPayment:
        if (validationEnum ==
            CalculatorValidationEnum.invalidFirstDownPayment) {
          return ("* Invalid First DownPayment");
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthFirstDownPayment) {
          return ("* First Down payment should contain at least ${calculatorInputParams.minLength} characters");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthFirstDownPayment) {
          return ("* First Down payment maximum characters is ${calculatorInputParams.maxLength - 1}");
        }
        return null;


    /// Second Down payment
      case CalculatorInputType.secondDownPayment:
        if (validationEnum ==
            CalculatorValidationEnum.invalidSecondDownPayment) {
          return ("* Invalid Second DownPayment");
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthSecondDownPayment) {
          return ("* Second Down payment should contain at least ${calculatorInputParams.minLength} characters");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthSecondDownPayment) {
          return ("* Second Down payment maximum characters is ${calculatorInputParams.maxLength - 1}");
        }
        return null;


    /// Third Down payment
      case CalculatorInputType.thirdDownPayment:
        if (validationEnum ==
            CalculatorValidationEnum.invalidThirdDownPayment) {
          return ("* Invalid Third DownPayment");
        } else if (validationEnum ==
            CalculatorValidationEnum.minLengthThirdDownPayment) {
          return ("* Third Down payment should contain at least ${calculatorInputParams.minLength} characters");
        } else if (validationEnum ==
            CalculatorValidationEnum.maxLengthThirdDownPayment) {
          return ("* Third Down payment maximum characters is ${calculatorInputParams.maxLength - 1}");
        }
        return null;

      default:
        return null;
    }
  }
}
