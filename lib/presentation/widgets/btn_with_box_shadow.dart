import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/extensions/widgetExtension.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../common/constants/sizes.dart';
import '../../common/enums/animation_type.dart';
import '../themes/theme_color.dart';

class ButtonWithBoxShadow extends StatelessWidget {
  final Function() onPressed;
  final String text;

  const ButtonWithBoxShadow(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
      child: ButtonTheme(
        height: Sizes.dimen_24.h,
        child: TextButton(
          onPressed: onPressed,
          child: Center(
              child: Text(
            text,
            style: Theme.of(context).textTheme.buttonText.copyWith(
                  fontSize: Sizes.dimen_18.sp,
                  fontWeight: FontWeight.w600,
                ),
          )),
        ),
      ),
      decoration: BoxDecoration(
        color: AppColor.geeBung,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: AppColor.geeBung, offset: Offset(1, -2), blurRadius: 5),
          BoxShadow(
              color: AppColor.geeBung, offset: Offset(-1, 2), blurRadius: 5)
        ],
      ),
    ).animate(
        slideDuration: const Duration(milliseconds: 300),
        fadeDuration: const Duration(milliseconds: 300),
        map: {
          AnimationType.slide: {
            SlideOffset.begin: const Offset(0.0, 0.5),
            SlideOffset.end: const Offset(0.0, 0.0),
          },
          AnimationType.fade: {
            FadeOpacity.begin: 0.5,
            FadeOpacity.end: 1.0,
          },
        });
  }
}
