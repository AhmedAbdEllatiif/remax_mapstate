import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class AppButtonGradient extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool reverseGradient;
  final Color? textColor;

  const AppButtonGradient(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.reverseGradient = false,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_20.w)),
      child: Container(
        height: Sizes.dimen_24.h,
        width: ScreenUtil.screenWidth * 0.5 - 15,
        color: AppColor.geeBung,
        /* decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_20.w)),
          gradient: LinearGradient(colors: _gradientColors()),
        ),*/
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.buttonText!.copyWith(
                  color: textColor ?? AppColor.black,
                  fontSize: Sizes.dimen_16.sp,

                ),
          ),
        ),
      ),
    );
  }

  /// return list of colors
  List<Color> _gradientColors() => reverseGradient
      ? [AppColor.violet, AppColor.royalBlue]
      : [AppColor.royalBlue, AppColor.violet];
}
