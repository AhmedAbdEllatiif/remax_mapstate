import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/params/app_text_form_field_params.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';

import '../../../../common/constants/translate_constatns.dart';
import '../../../widgets/btn_with_box_shadow.dart';

class LoginForm extends StatefulWidget {
  final Function() onSuccessLogin;

  const LoginForm({Key? key, required this.onSuccessLogin}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final passwordKey = GlobalKey();

  final loginEmailKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Wrap(
          alignment: WrapAlignment.center,
          //spacing: 20, // to apply margin in the main axis of the wrap
          runSpacing: Sizes.dimen_4.h,
          children: [
            /// email
            AppTextFormField(
              key: loginEmailKey,
              label: TranslateConstants.email.t(context),
              textInputType: TextInputType.emailAddress,
            ),

            /// password
            AppTextFormField(
              key: passwordKey,
              label: TranslateConstants.password.t(context),
              textInputType: TextInputType.visiblePassword,
            ),

            ButtonWithBoxShadow(
              text: TranslateConstants.login.t(context).toUpperCase(),
              onPressed: widget.onSuccessLogin,
            )
          ],
        ),
      ),
    );
  }
}
