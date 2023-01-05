import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';

import '../../../../common/constants/translate_constatns.dart';
import '../../../widgets/btn_with_box_shadow.dart';

class AmbassadorRegistrationFrom extends StatefulWidget {
  final Function() onSuccessRegister;

  const AmbassadorRegistrationFrom({Key? key, required this.onSuccessRegister})
      : super(key: key);

  @override
  State<AmbassadorRegistrationFrom> createState() =>
      _AmbassadorRegistrationFromState();
}

class _AmbassadorRegistrationFromState
    extends State<AmbassadorRegistrationFrom> {
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
            /// firstName
            AppTextFormField(
              label: TranslateConstants.firstName.t(context),
              textInputType: TextInputType.name,
            ),

            /// lastName
            AppTextFormField(
              label: TranslateConstants.lastName.t(context),
              textInputType: TextInputType.name,
            ),

            /// email
            AppTextFormField(
              label: TranslateConstants.email.t(context),
              textInputType: TextInputType.emailAddress,
            ),

            /// current job
            AppTextFormField(
              label: TranslateConstants.currentJob.t(context),
              textInputType: TextInputType.text,
            ),

            /// password
            AppTextFormField(
              label: TranslateConstants.password.t(context),
              textInputType: TextInputType.visiblePassword,
            ),

            /// button
            ButtonWithBoxShadow(
              text: TranslateConstants.register.t(context),
              onPressed: widget.onSuccessRegister,
            )
          ],
        ),
      ),
    );
  }
}
