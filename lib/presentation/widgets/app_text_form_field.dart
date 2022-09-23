import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../../domain/entities/params/app_text_form_field_params.dart';
import '../themes/theme_color.dart';

class AppTextFormField extends StatelessWidget {

  final TextFormFieldParams params;
  final bool isPassword;

  const AppTextFormField({Key? key, required this.params,  this.isPassword= false}) : super(key: key);


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
        keyboardType: params.keyboardType,
        textInputAction: params.nextInputAction,
        initialValue: '',
        cursorColor: AppColor.geeBung,
        obscureText: isPassword,
        style: const TextStyle(color: AppColor.geeBung),
        /*onFieldSubmitted:(_) {
          if(calculatorInputParams.inputType ==
              CalculatorInputType.numberOfYears){
            context
                .read<CalculatorValidationBloc>()
                .add(SubmitCalculatorFormEvent());

          }
        },*/

        /*onSaved: (_) {
          print("Keyboard Done Saved");
        },*/
        /*inputFormatters: [
          if (calculatorInputParams.inputType ==
              CalculatorInputType.unitPrice)
            ThousandsFormatter(),
          LengthLimitingTextInputFormatter(
              calculatorInputParams.maxLength + 4),
          if (calculatorInputParams.inputType !=
              CalculatorInputType.unitPrice)
            LengthLimitingTextInputFormatter(
                calculatorInputParams.maxLength),
        ],*/

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
          labelText: params.label,
          // errorMaxLines: ,
          labelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: AppColor.geeBung,
            fontWeight: FontWeight.bold,
            fontSize: Sizes.dimen_16,
          ),
          //errorStyle: const TextStyle(color: Colors.red),
          //errorText: _getError(state.calculatorValidationEnum),
        ),



        /*onChanged: (value) {
          _addEvent(context, value);
        },*/
      ),
    );
  }
}
