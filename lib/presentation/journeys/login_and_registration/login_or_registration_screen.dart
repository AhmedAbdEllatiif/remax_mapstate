import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/authorized_user_entity.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';

import '../../../common/constants/sizes.dart';
import '../../../common/constants/translate_constatns.dart';
import '../../../di/git_it.dart';
import '../../../domain/entities/arguments/register_or_login_args.dart';
import '../../../router/route_hepler.dart';
import '../../logic/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import '../../logic/cubit/user_token/user_token_cubit.dart';
import '../../widgets/logo_with_slogan.dart';
import '../../widgets/text_login_instead.dart';

import 'login_form.dart';
import 'registration_form.dart';

class RegisterOrLoginScreen extends StatefulWidget {
  final RegisterOrLoginArguments registerOrLoginArguments;

  const RegisterOrLoginScreen(
      {Key? key, required this.registerOrLoginArguments})
      : super(key: key);

  @override
  _RegisterOrLoginScreenState createState() => _RegisterOrLoginScreenState();
}

class _RegisterOrLoginScreenState extends State<RegisterOrLoginScreen> {
  late final ChooseFavoriteAreaCubit _chooseFavoriteAreaCubit;

  bool isLoginForm = true;
  String userEmail = "";
  String userPassword = "";

  String userToken = '';
  UserType currentRegisteredUserType = UserType.unDefined;

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
      body: Padding(
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
                password: userPassword,
                onSuccessLogin: (userToken, authorizedUserEntity) async {
                  //==> save current user token
                  await _saveTokenForAutoLogin(token: userToken);

                  //==> save current authorized user
                  log("UserEntity: $authorizedUserEntity");
                  authorizedUserEntity.userType =
                      widget.registerOrLoginArguments.userType;
                  await _saveAuthorizedUser(
                    authorizedUserEntity: authorizedUserEntity,
                  );

                  //==> navigate to login
                  _navigateToMainScreen();
                },
              )
                  : BrokerRegisterForm(
                  userType: widget.registerOrLoginArguments.userType,
                  onRegistrationSuccess: (registerEntity, userType) async {
                    // update data
                    userToken = registerEntity.userToken;
                    currentRegisteredUserType = userType;

                    _changeBetweenLoginAndRegistration();
                  },
              ),
            ),

            TextLoginInstead(
              isLogin: isLoginForm,
              onPressed: () => _changeBetweenLoginAndRegistration(),
            ),
          ],
        ),
      ),
    );
  }

  /// to change between login and registration
  void _changeBetweenLoginAndRegistration() =>
      setState(() {
        isLoginForm = !isLoginForm;
      });

  /// to save token for auto login
  Future<void> _saveTokenForAutoLogin({required String token}) =>
      context.read<UserTokenCubit>().save(token);

  /// to save the current authorized user
  Future<void> _saveAuthorizedUser(
      {required AuthorizedUserEntity authorizedUserEntity}) =>
      context.read<AuthorizedUserCubit>().save(authorizedUserEntity);

  /// Navigate to MainScreen
  void _navigateToMainScreen() =>
      RouteHelper().mainScreen(context, isClearStack: true);
}
