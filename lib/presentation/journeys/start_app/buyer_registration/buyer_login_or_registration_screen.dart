import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/login_form/login_form.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/buyer_registration/buyer_registration_form.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/login_form/text_login_instead.dart';
import 'package:remax_mapstate/presentation/widgets/logo_with_slogan.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../di/git_it.dart';
import '../../../logic/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';

class ClientLoginOrRegistrationScreen extends StatefulWidget {
  const ClientLoginOrRegistrationScreen({Key? key}) : super(key: key);

  @override
  _ClientLoginOrRegistrationScreenState createState() =>
      _ClientLoginOrRegistrationScreenState();
}

class _ClientLoginOrRegistrationScreenState
    extends State<ClientLoginOrRegistrationScreen> {
  final firstNameKey = GlobalKey();
  final lastNameKey = GlobalKey();
  final emailKey = GlobalKey();
  bool isLoginForm = true;

  late final ChooseFavoriteAreaCubit _chooseFavoriteAreaCubit;

  @override
  void initState() {
    super.initState();
    _chooseFavoriteAreaCubit = getItInstance<ChooseFavoriteAreaCubit>();
  }

  @override
  void dispose() {
    _chooseFavoriteAreaCubit.close();
    super.dispose();
  }

  void _changeBetweenLoginAndRegistration() => setState(() {
        isLoginForm = !isLoginForm;
      });

  @override
  Widget build(BuildContext context) {
    return StackScaffoldWithFullBackground(
      /// appBar Title
      appBarTitle: isLoginForm
          ? Text(TranslateConstants.login.t(context))
          : Text(TranslateConstants.buyerRegistration.t(context)),

      /// body
      body: BlocProvider(
        create: (_) => _chooseFavoriteAreaCubit,
        child: Container(
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

                // Flexible(
                //   child: isLoginForm
                //       ? LoginForm(
                //           onSuccessLogin: (value) {
                //             //_saveAutoLogin();
                //             _navigateToMainScreen();
                //           },
                //         )
                //       : RegistrationFrom(
                //           chooseFavoriteAreaCubit: _chooseFavoriteAreaCubit,
                //           onSuccessRegister: () {
                //             //_saveAutoLogin();
                //
                //             _navigateToMainScreen();
                //           },
                //         ),
                // ),

                /// Button Register a new client
                /* ButtonWithBoxShadow(
                  text: isLoginForm
                      ? TranslateConstants.login.t(context).toUpperCase()
                      : TranslateConstants.register.t(context).toUpperCase(),
                  onPressed: () {
                    _saveAutoLogin();

                    _navigateToMainScreen();
                  },
                ),*/

                TextLoginInstead(
                  isLogin: isLoginForm,
                  onPressed: () => _changeBetweenLoginAndRegistration(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Navigate to MainScreen
  void _navigateToMainScreen() =>
      RouteHelper().mainScreen(context, isClearStack: true);
}
