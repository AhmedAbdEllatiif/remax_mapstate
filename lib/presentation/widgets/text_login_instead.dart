import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/extensions/widgetExtension.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../../common/enums/animation_type.dart';

class TextLoginInstead extends StatelessWidget {
  final bool isLogin;
  final Function() onPressed;

  const TextLoginInstead({
    Key? key,
    required this.isLogin,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              isLogin
                  ? TranslateConstants.notHaveAbAccount.t(context)
                  : TranslateConstants.alreadyHaveAbAccount.t(context),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    letterSpacing: 0,
                    color: AppColor.white,
                  )),
          InkWell(
            onTap: onPressed,
            splashColor: AppColor.geeBung,
            hoverColor: AppColor.geeBung,
            borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10.w)),
            child: Text(
                isLogin
                    ? TranslateConstants.register.t(context).toUpperCase()
                    : TranslateConstants.login.t(context).toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                      color: AppColor.geeBung,
                    )),
          )
        ],
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
          }),
    );
  }
}
