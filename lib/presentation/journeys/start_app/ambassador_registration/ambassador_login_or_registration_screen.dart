import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/ambassador_registration/ambassador_register_form.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/constants/translate_constatns.dart';
import '../../../../router/route_hepler.dart';
import '../../../widgets/app_text_form_field.dart';
import '../../../widgets/btn_with_box_shadow.dart';
import '../../../widgets/logo_with_slogan.dart';
import '../broker_registartion/borker_register_form.dart';
import '../login_form/login_form.dart';
import '../login_form/text_login_instead.dart';

class SpotterRegistrationScreen extends StatefulWidget {
  const SpotterRegistrationScreen({Key? key}) : super(key: key);

  @override
  _SpotterRegistrationScreenState createState() =>
      _SpotterRegistrationScreenState();
}

class _SpotterRegistrationScreenState extends State<SpotterRegistrationScreen> {
  final firstNameKey = GlobalKey();
  final lastNameKey = GlobalKey();
  final emailKey = GlobalKey();
  final jobKey = GlobalKey();

  bool isLoginForm = true;

  @override
  Widget build(BuildContext context) {
    return StackScaffoldWithFullBackground(
      appBarTitle: isLoginForm
          ? Text(TranslateConstants.login.t(context))
          : Text(TranslateConstants.ambassadorRegistration.t(context)),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.dimen_10.h,
            left: Sizes.dimen_32.w,
            right: Sizes.dimen_32.w,
          ),
          child: Column(
            children: [
              /// Logo with slogan
              LogoWithSlogan(
                margin: EdgeInsets.only(
                  top: Sizes.dimen_12.h,
                  bottom: Sizes.dimen_20.h,
                ),
              ),

              /// register Form
              // Flexible(
              //   child: isLoginForm
              //       ? LoginForm(
              //           onSuccessLogin: (value) {
              //             //_saveAutoLogin();
              //             _navigateToMainScreen();
              //           },
              //         )
              //       : AmbassadorRegistrationFrom(
              //           onSuccessRegister: () {
              //             //_saveAutoLogin();
              //             _navigateToMainScreen();
              //           },
              //         ),
              // ),

              TextLoginInstead(
                isLogin: isLoginForm,
                onPressed: () => _changeBetweenLoginAndRegistration(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// to change between login and registration
  void _changeBetweenLoginAndRegistration() => setState(() {
        isLoginForm = !isLoginForm;
      });


  /// Navigate to MainScreen
  void _navigateToMainScreen() =>
      RouteHelper().mainScreen(context, isClearStack: true);
}
