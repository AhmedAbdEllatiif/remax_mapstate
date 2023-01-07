import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/authorized_user_entity.dart';
import 'package:remax_mapstate/presentation/logic/cubit/authorized_user/authorized_user_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../../common/constants/translate_constatns.dart';
import '../../../../router/route_hepler.dart';

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
    BlocProvider.of<AuthorizedUserCubit>(context)
        .save(AuthorizedUserEntity.empty());
  }

  /// navigate to MainScreen
  void _navigateToMainScreen(BuildContext context) =>
      RouteHelper().mainScreen(context, isClearStack: false);
}
