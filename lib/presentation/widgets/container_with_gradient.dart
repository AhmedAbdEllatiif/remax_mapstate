import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

import '../themes/theme_color.dart';

class ContainerWithGradient extends StatelessWidget {
  final Widget child;

  const ContainerWithGradient({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColor.extraFadeGeeBung,
            AppColor.fadeGeeBung,
            AppColor.geeBung,
          ],
        ),
        borderRadius:
            BorderRadius.all(Radius.circular(AppUtils.cornerRadius.w)),
      ),
      child: child,
    );
  }
}
