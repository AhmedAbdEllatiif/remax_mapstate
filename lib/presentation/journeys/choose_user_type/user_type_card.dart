import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/arguments/register_or_login_args.dart';
import 'package:remax_mapstate/domain/entities/authorized_user_entity.dart';
import 'package:remax_mapstate/presentation/arguments/business_model_args.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../logic/cubit/first_launch/first_launch_cubit.dart';
import '../../themes/theme_color.dart';

class UserTypeButton extends StatefulWidget {
  final UserType userType;

  const UserTypeButton({Key? key, required this.userType}) : super(key: key);

  @override
  State<UserTypeButton> createState() => _UserTypeButtonState();
}

class _UserTypeButtonState extends State<UserTypeButton> {
  late final bool _isFirstTimeToOpenApp;

  @override
  void initState() {
    super.initState();
    _isFirstTimeToOpenApp = context.read<FirstLaunchStatusCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.geeBung.withAlpha(100),
      margin: EdgeInsets.only(bottom: Sizes.dimen_10.h),
      elevation: 1,
      shadowColor: AppColor.fadeGeeBung,
      child: InkWell(
        //hoverColor: AppColor.geeBung,
        splashColor: AppColor.geeBung,
        borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10.w)),
        onTap: () async {
          log("FirstLaunchStatus: >> $_isFirstTimeToOpenApp");

          /// update currentUser
          await _updateCurrentUser(context);

          /// navigate to MainScreen
          _navigateToNextScreen(context);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 3),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColor.extraFadeGeeBung,
                AppColor.fadeGeeBung,
                AppColor.geeBung,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10.w)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "REAL STATE",
                style: Theme.of(context).textTheme.buttonTextSmall,
              ),
              Text(
                widget.userType.toShortString().t(context).toUpperCase(),
                style: Theme.of(context).textTheme.buttonTextLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// update currentUser
  Future<void> _updateCurrentUser(BuildContext context) async {
    BlocProvider.of<AuthorizedUserCubit>(context)
        .save(AuthorizedUserEntity.empty());
  }

  void _navigateToNextScreen(BuildContext context) {
    _isFirstTimeToOpenApp
        ? _navigateToBusinessModelScreen(context)
        : _navigateToRegisterOrLoginScreen(context);
  }

  /// navigate to LoginScreen
  void _navigateToRegisterOrLoginScreen(BuildContext context) {
    RouteHelper().registerOrLoginScreen(
      context,
      registerOrLoginArguments: RegisterOrLoginArguments(
        userType: widget.userType,
      ),
    );
  }

  /// navigate to BusinessModelScreen
  void _navigateToBusinessModelScreen(BuildContext context) {
    RouteHelper().businessModelScreen(
      context,
      arguments: BusinessModelArguments(
        userType: widget.userType,
      ),
    );
  }
}
