import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/not_user_login_first/not_user_animation.dart';
import 'package:remax_mapstate/presentation/widgets/btn_with_box_shadow.dart';

class NotAUserLoginFirstScreen extends StatelessWidget {
  const NotAUserLoginFirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [

          /// not user animation
          SizedBox(
            height: Sizes.dimen_100.h,
            width: Sizes.dimen_100.w,
            child: const NotUserAnimation(),
          ),

          /// btn login
          ButtonWithBoxShadow(
            onPressed: () {},
            text: TranslateConstants.login.t(context),
          ),
        ],
      ),
    );
  }
}
