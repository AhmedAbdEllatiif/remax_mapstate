import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';
import 'package:remax_mapstate/presentation/widgets/choose_area_widget.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../di/git_it.dart';
import '../../../../domain/entities/params/app_text_form_field_params.dart';
import '../../../cubit/auto_login/auto_login_cubit.dart';
import '../../../widgets/btn_with_box_shadow.dart';

class ClientRegistrationScreen extends StatefulWidget {
  const ClientRegistrationScreen({Key? key}) : super(key: key);

  @override
  _ClientRegistrationScreenState createState() =>
      _ClientRegistrationScreenState();
}

class _ClientRegistrationScreenState extends State<ClientRegistrationScreen> {
  final firstNameKey = GlobalKey();
  final lastNameKey = GlobalKey();
  final emailKey = GlobalKey();

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _chooseFavoriteAreaCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(TranslateConstants.clientRegistration.t(context)),
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

                  ChooseFavoriteAreaWidget(
                    allAreas: const [
                      AreaEntity(id: 1, title: "Zayed"),
                      AreaEntity(id: 2, title: "October"),
                      AreaEntity(id: 3, title: "Sokhna"),
                      AreaEntity(id: 4, title: "Sahel"),
                      AreaEntity(id: 5, title: "New Capital"),
                    ],
                    chooseFavoriteAreaCubit: _chooseFavoriteAreaCubit,
                  ),

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
      ),
    );
  }

  /// Save auto login
  void _saveAutoLogin() async => await context.read<AutoLoginCubit>().save();

  /// Navigate to MainScreen
  void _navigateToMainScreen() =>
      RouteHelper().mainScreen(context, isClearStack: true);
}
