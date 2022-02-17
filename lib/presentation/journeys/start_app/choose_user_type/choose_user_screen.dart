import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/choose_user_type/take_a_tour_button.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/screen_utils/screen_util.dart';
import 'choose_user_list_widget.dart';

class ChooseUserScreen extends StatelessWidget {
  const ChooseUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            /// background fullImage
            /* Expanded(
              child: Opacity(
                opacity: 0.4,
                child: Image.asset(
                  AssetsImages.city,
                  fit: BoxFit.cover,
                ),
              ),
            ),*/



            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                /// text select userType
                Container(
                  margin: EdgeInsets.only(bottom: Sizes.dimen_16.h),
                  child: Text(
                    TranslateConstants.selectUserType.t(context),
                    style: Theme.of(context).textTheme.whiteSpacingHeadLine6,
                  ),
                ),

                /// list of userTypes
                ChooseUserListWidget(),

                /// button take a tour
                Container(
                  margin: EdgeInsets.only(top: Sizes.dimen_40.h),
                  height: Sizes.dimen_18.h,
                  width: ScreenUtil.screenWidth * 0.5 - 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_16.w)),
                      border: Border.all(color: Colors.white70,width: 0.1)
                  ),
                  child: const TakeATourButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



