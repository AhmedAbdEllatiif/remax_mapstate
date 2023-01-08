import 'package:flutter/material.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';

class CloseWidget extends StatelessWidget {
  final Function() onPressed;
  const CloseWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(Sizes.dimen_3),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.white,
        ),

        /// Icon
        child: const Icon(
          Icons.clear,
          color: AppColor.geeBung,
        ),
      ),
    );
  }
}
