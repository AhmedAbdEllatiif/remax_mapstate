import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../bloc/login/login_bloc.dart';
import '../../../../themes/theme_color.dart';

class PinCodeForm extends StatelessWidget {
  final TextEditingController textEditingController;
  final StreamController<ErrorAnimationType>? errorController;
  final GlobalKey<FormState> formKey;

  const PinCodeForm(
      {Key? key,
      required this.textEditingController,
      required this.errorController,
      required this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.ltr,
      child: Form(
        key: formKey,
        child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Sizes.dimen_4.h, horizontal: Sizes.dimen_32.w),
            child: PinCodeTextField(
              appContext: context,
              textStyle: const TextStyle().copyWith(color: AppColor.black),
              pastedTextStyle: const TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
              length: 6,

              /// obscure
              /*   obscureText: true,
                  obscuringCharacter: '*',
                  obscuringWidget: FlutterLogo(
                    size: 24,
                  ),
                  blinkWhenObscuring: true,*/
              autoFocus: true,
              animationType: AnimationType.fade,
              validator: (v) {
                return '';
              },

              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textEditingController,
              keyboardType: TextInputType.number,


              cursorColor: AppColor.black,
              /// pinTheme
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(Sizes.dimen_6.w),
                fieldHeight: 50,
                fieldWidth: 40,

                /// OnSelected
                selectedFillColor: AppColor.transparentGeeBung,
                selectedColor: AppColor.geeBung, // frame color

                /// after pinItem filled
                activeFillColor: AppColor.geeBung,
                activeColor: AppColor.geeBung, // frame color

                /// not selected and not filled
                inactiveFillColor: AppColor.fadeGeeBung,
                inactiveColor: AppColor.fadeGeeBung, // frame color

                /// error border color
                errorBorderColor: Colors.red,
              ),


              boxShadows:  [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: AppColor.black,
                  blurRadius: Sizes.dimen_10.w,
                )
              ],

              /// onCompleted
              onCompleted: (v) {
                context.read<LoginBloc>().add(const VerifyPinCodeEvent());
              },

              /// onChanged
              onChanged: (value) {
                context.read<LoginBloc>().add(OnPinChanged(changedPin: value));
              },

              /// beforeTextPaste
              beforeTextPaste: (text) {
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            )),
      ),
    );
  }
}
