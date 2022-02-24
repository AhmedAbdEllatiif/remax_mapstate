import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/cubit/current_user/current_user_cubit.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../../../domain/entities/current_user.dart';

import '../../../themes/theme_color.dart';

class UserTypeCard extends StatelessWidget {
  final CurrentUserEntity currentUserEntity;

  const UserTypeCard({Key? key, required this.currentUserEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: AppColor.vulcan,
      splashColor: AppColor.vulcan,
      borderRadius:  BorderRadius.all(Radius.circular(Sizes.dimen_16.w)),
      onTap: () async {
        /// update currentUser
        await _updateCurrentUser(context);

        /// navigate to MainScreen
        _navigateToLoginScreen(context);
      },
      child: Card(
        color: AppColor.vulcan,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.dimen_16.w)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              color: AppColor.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              currentUserEntity.userType.toShortString().t(context).toUpperCase(),
              style: const TextStyle(color: AppColor.white),
            ),
          ],
        ),
        elevation: 15,
        shadowColor: AppColor.vulcan,
      ),
    );
  }

  /// update currentUser
  Future<void> _updateCurrentUser(BuildContext context) async {
    BlocProvider.of<CurrentUserCubit>(context).changeUser(CurrentUserEntity(
        currentUserStr: currentUserEntity.userType.toShortString()));
  }

  /// navigate to LoginScreen
  void _navigateToLoginScreen(BuildContext context) => RouteHelper().loginScreen(context);
}
