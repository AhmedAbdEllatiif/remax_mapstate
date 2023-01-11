import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/arguments/register_or_login_args.dart';
import 'package:remax_mapstate/domain/entities/authorized_user_entity.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../themes/theme_color.dart';

class UserTypeButton extends StatelessWidget {
  final UserType userType;

  const UserTypeButton({Key? key, required this.userType})
      : super(key: key);

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
          /// update currentUser
          await _updateCurrentUser(context);

          /// navigate to MainScreen
          _navigateToRegisterOrLoginScreen(context);
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
                userType
                    .toShortString()
                    .t(context)
                    .toUpperCase(),
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

  /// navigate to LoginScreen
  void _navigateToRegisterOrLoginScreen(BuildContext context) {
    RouteHelper().registerOrLoginScreen(
      context,
      registerOrLoginArguments: RegisterOrLoginArguments(
        userType: userType,
      ),
    );
  }
}
