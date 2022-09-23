import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/client_registration/login_form.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/client_registration/registration_form.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/client_registration/text_login_instead.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';
import 'package:remax_mapstate/presentation/widgets/choose_area_widget.dart';
import 'package:remax_mapstate/presentation/widgets/city_background_widget.dart';
import 'package:remax_mapstate/presentation/widgets/logo_with_slogan.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/params/app_text_form_field_params.dart';
import '../../../cubit/auto_login/auto_login_cubit.dart';
import '../../../widgets/btn_with_box_shadow.dart';

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
    return BlocProvider(
      create: (_) => _chooseFavoriteAreaCubit,
      child: Scaffold(
        appBar: AppBar(
          title: isLoginForm
              ? Text(TranslateConstants.login.t(context))
              : Text(TranslateConstants.buyerRegistration.t(context)),
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            const CityBackgroundWidget(),
            Scrollbar(
              child: Padding(
                padding: EdgeInsets.only(
                  top: Sizes.dimen_10.h,
                  left: Sizes.dimen_32.w,
                  right: Sizes.dimen_32.w,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Logo with slogan
                      LogoWithSlogan(
                        margin: EdgeInsets.only(
                          top: Sizes.dimen_12.h,
                          bottom: Sizes.dimen_20.h,
                        ),
                      ),


                      /// RegistrationFrom
                      if (!isLoginForm)
                        RegistrationFrom(
                          chooseFavoriteAreaCubit: _chooseFavoriteAreaCubit,
                        ),

                      /// loginForm
                      if (isLoginForm) LoginForm(),

                      /// Button Register a new client
                      ButtonWithBoxShadow(
                        text: isLoginForm
                            ? TranslateConstants.login.t(context).toUpperCase()
                            : TranslateConstants.register.t(context).toUpperCase(),
                        onPressed: () {
                          _saveAutoLogin();

                          _navigateToMainScreen();
                        },
                      ),


                      TextLoginInstead(isLogin: isLoginForm,
                      onPressed: ()=> _changeBetweenLoginAndRegistration() ,
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ],
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
