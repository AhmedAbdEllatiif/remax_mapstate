import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class TextLoginInstead extends StatelessWidget {
  final bool isLogin;
  final Function() onPressed;

  const TextLoginInstead(
      {Key? key, required this.isLogin, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
