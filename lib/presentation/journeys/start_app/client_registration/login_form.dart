import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/domain/entities/params/app_text_form_field_params.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';

class LoginForm extends StatelessWidget {

  final passwordKey = GlobalKey();
  final loginEmailKey = GlobalKey();
  
   LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// email
        AppTextFormField(
          key: loginEmailKey,
          params: TextFormFieldParams.fromTextInput(
            appTextInput: AppTextInput.email,
            context: context,
          ),
        ),
        SizedBox(height: Sizes.dimen_5.h),

        /// password
        AppTextFormField(
          key: passwordKey,
          isPassword: true,
          params: TextFormFieldParams.fromTextInput(
            appTextInput: AppTextInput.password,
            context: context,
          ),
        ),
        SizedBox(height: Sizes.dimen_5.h),
      ],
    );
  }
}
