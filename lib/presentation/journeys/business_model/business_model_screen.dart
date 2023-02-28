import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/arguments/business_model_args.dart';
import 'package:remax_mapstate/presentation/logic/cubit/first_launch/first_launch_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/btn_with_box_shadow.dart';

import '../../../common/constants/translate_constatns.dart';
import '../../../common/enums/user_types.dart';
import '../../../domain/entities/arguments/register_or_login_args.dart';
import '../../../router/route_hepler.dart';
import '../../widgets/logo_with_slogan.dart';

class BusinessModelScreen extends StatefulWidget {
  final BusinessModelArguments arguments;

  const BusinessModelScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<BusinessModelScreen> createState() => _BusinessModelScreenState();
}

class _BusinessModelScreenState extends State<BusinessModelScreen> {
  /// UserType
  late final UserType _userType;

  /// businessModelText
  late final String _businessModelText;

  @override
  void initState() {
    super.initState();
    _userType = widget.arguments.userType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// appbar
      appBar: widget.arguments.withAppBar ? AppBar(
        title: Text(
          TranslateConstants.businessModel.t(context)
        ),
      ) : null,


      body: Column(
        children: [
          /// Logo with slogan
          const Padding(
            padding: EdgeInsets.only(
              right: 8.0,
              left: 8.0,
              top: 8.0,
            ),
            child: LogoWithSlogan(),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
            constraints:
                BoxConstraints(maxHeight: ScreenUtil.screenHeight * 0.5),
            child: Scrollbar(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Text(
                  _initBusinessModelText(),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: AppColor.white),
                ),
              ),
            ),
          ),


          if(widget.arguments.withButton)
          ButtonWithBoxShadow(
            text: TranslateConstants.register.t(context),
            onPressed: () => _navigateToRegisterOrLoginScreen(),
          )
        ],
      ),
    );
  }

  String _initBusinessModelText() {
    switch (_userType) {
      case UserType.broker:
        return TranslateConstants.brokerBusinessModel.t(context);

      case UserType.ambassador:
        return TranslateConstants.ambassadorBusinessModel.t(context);

      case UserType.tour:
      case UserType.client:
      case UserType.unDefined:
        return TranslateConstants.buyerBusinessModel.t(context);
    }
  }

  /// navigate to LoginScreen
  void _navigateToRegisterOrLoginScreen() {
    /// to not show business model next time
    _changeAppFirstLaunchStatus();

    RouteHelper().registerOrLoginScreen(
      context,
      removeAllScreens: true,
      registerOrLoginArguments: RegisterOrLoginArguments(
        userType: _userType,
      ),
    );
  }

  void _changeAppFirstLaunchStatus() async {
    await context.read<FirstLaunchStatusCubit>().changeFirstLaunchStatus();
  }
}
