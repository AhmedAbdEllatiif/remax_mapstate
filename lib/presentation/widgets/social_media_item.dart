import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';

class SocialMediaItem extends StatelessWidget {
  final String text;
  final String img;
  final Function() onPressed;
  final Color? iconColor;

  const SocialMediaItem(
      {Key? key,
      required this.text,
      required this.img,
      required this.onPressed,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          iconSize: Sizes.dimen_22.h,
          splashColor: AppColor.black,
          splashRadius: Sizes.dimen_22.w,
          icon: Image.asset(
            img,
            fit: BoxFit.cover,
            color: iconColor,
          ),
          onPressed: onPressed,
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: AppColor.white),
        ),
      ],
    );
  }
}
