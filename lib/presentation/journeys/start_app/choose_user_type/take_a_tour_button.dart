import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/constants/translate_constatns.dart';
import '../../../../common/enums/user_types.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../router/route_hepler.dart';
import '../../../logic/cubit/current_user/current_user_cubit.dart';

class TakeATourButton extends StatelessWidget {
  const TakeATourButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await _updateCurrentUser(context);
        _navigateToMainScreen(context);
      },
      /*style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColor.vulcan) ,
            borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
          ),
        ),
      ),*/
      child: Text(
        TranslateConstants.enjoyATour.t(context),
        maxLines: 1,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.takeATourText,
      ),
    );
  }

  /// update currentUser
  Future<void> _updateCurrentUser(BuildContext context) async {
    BlocProvider.of<CurrentUserCubit>(context).changeUser(
      UserEntity(
        userType: UserType.tour,
        firstName: "",
        lastName: "",
        email: "",
        id: "-1",
        phoneNumber: "",
        favoriteAreas: [],
      ),
    );
  }

  /// navigate to MainScreen
  void _navigateToMainScreen(BuildContext context) =>
      RouteHelper().mainScreen(context, isClearStack: false);
}
