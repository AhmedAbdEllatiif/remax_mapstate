import 'package:flutter/material.dart';

import '../../common/constants/sizes.dart';
import '../themes/theme_color.dart';

class DoneWidget extends StatelessWidget {
  const DoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.dimen_16),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.geeBung,
      ),

      /// Icon
      child: const Icon(
        Icons.done,
        color: AppColor.white,
      ),
    );
  }
}
