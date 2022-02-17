import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/cubit/current_user/current_user_cubit.dart';

import '../../../../domain/entities/current_user.dart';
import '../../../../router/app_router.dart';
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
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      onTap: () async {
        /// update currentUser
        await _updateCurrentUser(context);

        /// navigate to MainScreen
        _navigateToMainScreen(context);
      },
      child: Card(
        //color: AppColors.darkGray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              color: AppColor.royalBlue,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              currentUserEntity.userType.toShortString().t(context).toUpperCase(),
              style: const TextStyle(color: AppColor.royalBlue),
            ),
          ],
        ),
        elevation: 5,
      ),
    );
  }

  /// update currentUser
  Future<void> _updateCurrentUser(BuildContext context) async {
    BlocProvider.of<CurrentUserCubit>(context).changeUser(CurrentUserEntity(
        currentUserStr: currentUserEntity.userType.toShortString()));
  }

  /// navigate to MainScreen
  void _navigateToMainScreen(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(context, AppRouter.mainScreen, (routePredicate) => false);
  }
}
