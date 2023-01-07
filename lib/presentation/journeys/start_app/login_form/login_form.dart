import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';

import '../../../../common/constants/translate_constatns.dart';
import '../../../widgets/btn_with_box_shadow.dart';

class LoginForm extends StatefulWidget {
  final Function() onSuccessLogin;
  final String email;

  const LoginForm({
    Key? key,
    required this.onSuccessLogin,
    this.email = "",
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  /// Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// formKey
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.email.isNotEmpty) {
      emailController.text = widget.email;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              controller: emailController,
              label: TranslateConstants.email.t(context),
              textInputType: TextInputType.emailAddress,
            ),

            /// password
            AppTextFormField(
              controller: passwordController,
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
