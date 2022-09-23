import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class LogoWithSlogan extends StatelessWidget {
  final String logoPath;
  final bool withSlogan;
  final Color sloganColor;
  final EdgeInsets? margin;

  const LogoWithSlogan({
    Key? key,
    this.logoPath = AssetsConstants.whiteGoldLogo,
    this.withSlogan = true,
    this.sloganColor = AppColor.fadeGeeBung,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          EdgeInsets.only(top: Sizes.dimen_22.h, bottom: Sizes.dimen_20.h),
      child: Column(
        children: [
          /// logo
          Image.asset(logoPath),

          /// slogan
          if (withSlogan)
            Text(
              "Lets' Earn More".toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    letterSpacing: 2,
                    color: sloganColor,
                  ),
            )
        ],
      ),
    );
  }
}
