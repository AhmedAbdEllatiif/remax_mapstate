import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../common/constants/sizes.dart';
import '../../../domain/entities/params/calculator_input.dart';
import '../../bloc/calculator_validation/calculator_validation_bloc.dart';
import '../../themes/theme_color.dart';

class TextFieldCalculator extends StatelessWidget {

  final CalculatorInputParams calculatorInputParams;

  const TextFieldCalculator({Key? key, required this.calculatorInputParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Card(
      elevation: 10.0,
      shadowColor: AppColor.vulcan,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      ),
      child: TextFormField(
        //initialValue: initialValue,
        keyboardType: TextInputType.number,
        textInputAction: calculatorInputParams.inputType !=
            CalculatorInputType.numberOfYears
            ? TextInputAction.next
            : TextInputAction.done,
        initialValue: calculatorInputParams.initialValue,
        cursorColor: AppColor.vulcan,
        style: const TextStyle(color: AppColor.vulcan),
        inputFormatters: [
          if (calculatorInputParams.inputType ==
              CalculatorInputType.unitPrice)
            ThousandsFormatter(),
          LengthLimitingTextInputFormatter(
              calculatorInputParams.maxLength + 4),
          if (calculatorInputParams.inputType !=
              CalculatorInputType.unitPrice)
            LengthLimitingTextInputFormatter(
                calculatorInputParams.maxLength),
        ],

        // maxLength: 5,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
            borderSide:
            const BorderSide(color: AppColor.royalBlue, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
            borderSide:
            const BorderSide(color: AppColor.vulcan, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
          ),
          fillColor: AppColor.white,
          labelText: calculatorInputParams.label,
          // errorMaxLines: ,
          labelStyle: Theme.of(context).textTheme.royalBlueSubtitle1,
          //errorStyle: const TextStyle(color: Colors.red),
          //errorText: _getError(state.calculatorValidationEnum),
        ),



        onChanged: (value) {
          _addEvent(context, value);
        },
      ),
    );
  }


  void _addEvent(BuildContext context, value) {
    switch (calculatorInputParams.inputType) {
      case CalculatorInputType.unitPrice:
        {
          context.read<CalculatorValidationBloc>().add(
            UnitPriceChangedEvent(
              currentStringOnChange: value,
              params: calculatorInputParams,
            ),
          );
          break;
        }
      case CalculatorInputType.downPayment:
        {
          context.read<CalculatorValidationBloc>().add(
            DownPaymentChangedEvent(
              currentStringOnChange: value,
              params: calculatorInputParams,
            ),
          );
          break;
        }
      case CalculatorInputType.numberOfYears:
        {
          context.read<CalculatorValidationBloc>().add(
            NumberOfYearsChangedEvent(
              currentStringOnChange: value,
              params: calculatorInputParams,
            ),
          );
          break;
        }
    }
  }
}
