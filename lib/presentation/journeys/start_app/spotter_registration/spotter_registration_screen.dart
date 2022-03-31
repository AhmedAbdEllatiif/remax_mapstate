import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/constants/translate_constatns.dart';
import '../../../../domain/entities/params/app_text_form_field_params.dart';
import '../../../../router/route_hepler.dart';
import '../../../cubit/auto_login/auto_login_cubit.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/btn_with_box_shadow.dart';

class SpotterRegistrationScreen extends StatefulWidget {
  const SpotterRegistrationScreen({Key? key}) : super(key: key);

  @override
  _SpotterRegistrationScreenState createState() => _SpotterRegistrationScreenState();
}

class _SpotterRegistrationScreenState extends State<SpotterRegistrationScreen> {

  final firstNameKey = GlobalKey();
  final lastNameKey = GlobalKey();
  final emailKey = GlobalKey();
  final jobKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslateConstants.spotterRegistration.t(context)),
      ),
      body: Scrollbar(
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.dimen_10.h,
            left: Sizes.dimen_32.w,
            right: Sizes.dimen_32.w,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                /// firstName
                AppTextFormField(
                  key: firstNameKey,
                  params: TextFormFieldParams.fromTextInput(
                    appTextInput: AppTextInput.firstName,
                    context: context,
                  ),
                ),
                SizedBox(height: Sizes.dimen_5.h),

                /// lastName
                AppTextFormField(
                  key: lastNameKey,
                  params: TextFormFieldParams.fromTextInput(
                    appTextInput: AppTextInput.lastName,
                    context: context,
                  ),
                ),
                SizedBox(height: Sizes.dimen_5.h),

                /// email
                AppTextFormField(
                  key: emailKey,
                  params: TextFormFieldParams.fromTextInput(
                    appTextInput: AppTextInput.email,
                    context: context,
                  ),
                ),
                SizedBox(height: Sizes.dimen_5.h),


                /// spotter job
                AppTextFormField(
                  key: jobKey,
                  params: TextFormFieldParams.fromTextInput(
                    appTextInput: AppTextInput.job,
                    context: context,
                  ),
                ),
                SizedBox(height: Sizes.dimen_5.h),

                /// Button Register a new client
                ButtonWithBoxShadow(
                  text: TranslateConstants.register.t(context),
                  onPressed: () {
                     _saveAutoLogin();
                    _navigateToMainScreen();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Save auto login
  void _saveAutoLogin() async => await context.read<AutoLoginCubit>().save();

  /// Navigate to MainScreen
  void _navigateToMainScreen() =>
      RouteHelper().mainScreen(context, isClearStack: true);
}
