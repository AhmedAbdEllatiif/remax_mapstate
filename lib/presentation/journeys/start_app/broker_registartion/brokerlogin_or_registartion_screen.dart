import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/broker_registartion/borker_register_form.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/login_form/login_form.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/constants/translate_constatns.dart';
import '../../../../di/git_it.dart';
import '../../../../router/route_hepler.dart';
import '../../../logic/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import '../../../logic/cubit/user_token/user_token_cubit.dart';
import '../../../widgets/logo_with_slogan.dart';
import '../login_form/text_login_instead.dart';

class BrokerLoginOrRegistrationScreen extends StatefulWidget {
  const BrokerLoginOrRegistrationScreen({Key? key}) : super(key: key);

  @override
  _BrokerLoginOrRegistrationScreenState createState() =>
      _BrokerLoginOrRegistrationScreenState();
}

class _BrokerLoginOrRegistrationScreenState
    extends State<BrokerLoginOrRegistrationScreen> {
  final firstNameKey = GlobalKey();
  final lastNameKey = GlobalKey();
  final emailKey = GlobalKey();
  final numOfExperienceYears = GlobalKey();

  late final ChooseFavoriteAreaCubit _chooseFavoriteAreaCubit;

  bool isLoginForm = true;
  String userEmail = "";

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

  @override
  Widget build(BuildContext context) {
    return StackScaffoldWithFullBackground(
      appBarTitle: isLoginForm
          ? Text(TranslateConstants.login.t(context))
          : Text(TranslateConstants.brokerRegistration.t(context)),
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
              Flexible(
                child: isLoginForm
                    ? LoginForm(
                        email: userEmail,
                        onSuccessLogin: (userToken) async {
                          await _saveForAutoLogin(token: userToken);

                          _navigateToMainScreen();
                        },
                      )
                    : BrokerRegisterForm(
                        onRegistrationSuccess: (userEntity) async {
                        // await BlocProvider.of<CurrentUserCubit>(context)
                        //     .changeUser(userEntity);
                        // await _saveAutoLogin();
                        // _navigateToMainScreen();
                        userEmail = userEntity.email;
                        _changeBetweenLoginAndRegistration();
                      }),
              ),

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

  /// to save token for auto login
  Future<void> _saveForAutoLogin({required String token}) =>
      context.read<UserTokenCubit>().save(token);

  /// Navigate to MainScreen
  void _navigateToMainScreen() =>
      RouteHelper().mainScreen(context, isClearStack: true);
}
