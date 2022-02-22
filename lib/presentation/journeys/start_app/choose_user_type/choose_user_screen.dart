import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/choose_user_type/choose_user_animation.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/choose_user_type/take_a_tour_button.dart';
import 'package:remax_mapstate/presentation/journeys/start_app/choose_user_type/toggle_language_widget.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import 'choose_user_list_widget.dart';
import '../../../../common/constants/sizes.dart';
import '../../../../common/screen_utils/screen_util.dart';

class ChooseUserScreen extends StatelessWidget {
  const ChooseUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h,horizontal: Sizes.dimen_10.h ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                /// toggle language
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    ToggleLanguageWidget(),
                  ],
                ),

                /// Lottie animation
                Container(
                  width: ScreenUtil.screenWidth,
                  height: ScreenUtil.screenHeight * 0.20,
                  margin: EdgeInsets.only(top:Sizes.dimen_10.h ),
                  child: const ChooseUserAnimation(),
                ),


                /// list of userTypes
                Container(
                    margin: EdgeInsets.only(top: Sizes.dimen_10.h),
                    child: ChooseUserListWidget()),

                /// button take a tour
                Container(
                  margin: EdgeInsets.only(top: Sizes.dimen_22.h),
                  height: Sizes.dimen_18.h,
                  width: ScreenUtil.screenWidth * 0.5 - 15,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Sizes.dimen_16.w)),
                      border: Border.all(color: Colors.white70, width: 0.1)),
                  child: const TakeATourButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
