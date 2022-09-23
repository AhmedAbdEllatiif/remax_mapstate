import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../common/constants/sizes.dart';
import '../../../domain/entities/params/calculator_input.dart';
import '../../logic/bloc/calculator_validation/calculator_validation_bloc.dart';
import '../../themes/theme_color.dart';

class TextFieldCalculator extends StatelessWidget {

  final CalculatorInputParams calculatorInputParams;

  const TextFieldCalculator({Key? key, required this.calculatorInputParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Card(
      color: AppColor.extraTransparentGeeBung,
      elevation: 0.0,
      //shadowColor: AppColor.absoluteFadeGeeBung,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      ),
      child: TextFormField(
        //initialValue: initialValue,
        keyboardType: TextInputType.number,
        textInputAction: calculatorInputParams.inputType !=
            CalculatorInputType.thirdDownPayment
            ? TextInputAction.next
            : TextInputAction.done,
        initialValue: calculatorInputParams.initialValue,
        cursorColor: AppColor.geeBung,
        style: const TextStyle(color: AppColor.geeBung),
        onFieldSubmitted:(_) {
          if(calculatorInputParams.inputType ==
              CalculatorInputType.numberOfYears){
            context
                .read<CalculatorValidationBloc>()
                .add(SubmitCalculatorFormEvent());

          }
        },

        onSaved: (_) {
          print("Keyboard Done Saved");
        },
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

        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
            borderSide:
            const BorderSide(color: AppColor.geeBung, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
            borderSide:
            const BorderSide(color: AppColor.absoluteTransparentGeeBung, width: 0.7),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
          ),
          fillColor: AppColor.geeBung,
          labelText: calculatorInputParams.label,
          // errorMaxLines: ,
          labelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: AppColor.geeBung,
            fontWeight: FontWeight.bold,
              fontSize: Sizes.dimen_16,
          ),
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

      /// unitPrice
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

        /// downPayment
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

        /// numberOfYears
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

        /// firstDownPayment
      case CalculatorInputType.firstDownPayment:
        {
          context.read<CalculatorValidationBloc>().add(
            FirstDownPaymentChangedEvent(
              currentStringOnChange: value,
              params: calculatorInputParams,
            ),
          );
          break;
        }
        /// secondDownPayment
      case CalculatorInputType.secondDownPayment:
        {
          context.read<CalculatorValidationBloc>().add(
            SecondDownPaymentChangedEvent(
              currentStringOnChange: value,
              params: calculatorInputParams,
            ),
          );
          break;
        }
        /// thirdDownPayment
      case CalculatorInputType.thirdDownPayment:
        {
          context.read<CalculatorValidationBloc>().add(
            ThirdDownPaymentChangedEvent(
              currentStringOnChange: value,
              params: calculatorInputParams,
            ),
          );
          break;
        }
    }
  }
}
