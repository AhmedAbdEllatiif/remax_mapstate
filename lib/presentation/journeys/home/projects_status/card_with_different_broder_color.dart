import 'package:flutter/material.dart';

import '../../../../common/constants/assets_constants.dart';
import '../../../../common/screen_utils/screen_util.dart';
import '../../../themes/theme_color.dart';

class CardWithDifferentBorderColor extends StatelessWidget {
  final Widget child;

  const CardWithDifferentBorderColor({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.screenWidth * 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),

        gradient: const LinearGradient(
          colors: [
            AppColor.geeBung,
            AppColor.geeBung,
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.white,
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.6),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(28),
            // boxShadow: const [
            //   BoxShadow(
            //       color: AppColor.geeBung, offset: Offset(1, -2), blurRadius: 5),
            //   BoxShadow(
            //       color: AppColor.geeBung, offset: Offset(-1, 2), blurRadius: 5)
            // ],
          ),
          child: child,
        ),
      ),
    );
  }
}
