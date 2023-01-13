import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/not_user_login_first/not_user_animation.dart';
import 'package:remax_mapstate/presentation/widgets/btn_with_box_shadow.dart';
import 'package:remax_mapstate/presentation/widgets/city_background_widget.dart';

import '../../../router/route_hepler.dart';

class NotAUserLoginFirstScreen extends StatelessWidget {
  const NotAUserLoginFirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        const CityBackgroundWidget(),

        Center(
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
                onPressed: () => _navigateChooseUserType(context),
                text: TranslateConstants.login.t(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// to navigate choose user type
  void _navigateChooseUserType(BuildContext context) {
    RouteHelper().chooseUserTypeScreen(context, isClearStack: true);
  }
}
