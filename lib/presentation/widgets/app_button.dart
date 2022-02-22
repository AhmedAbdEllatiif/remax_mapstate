import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool reverseGradient;

  const AppButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.reverseGradient = false})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.dimen_18.h,
      width: ScreenUtil.screenWidth * 0.5 - 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_20.w)),
        gradient: LinearGradient(colors: _gradientColors()),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.buttonText,
        ),
      ),
    );
  }


  /// return list of colors
  List<Color> _gradientColors() => reverseGradient
      ? [AppColor.violet, AppColor.royalBlue]
      : [AppColor.royalBlue, AppColor.violet];

}
