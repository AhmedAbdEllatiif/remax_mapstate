import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import '../../common/constants/sizes.dart';
import '../../common/screen_utils/screen_util.dart';
import '../themes/theme_color.dart';

class BottomButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const BottomButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: AppColor.fadeBlack,
      child: Container(
        height: ScreenUtil.screenHeight * 0.08,
        decoration: BoxDecoration(
            color: AppColor.geeBung,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Sizes.dimen_20.w),
                topLeft: Radius.circular(Sizes.dimen_20.w))),
        child: Center(
            child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
        )),
      ),
    );
  }
}
