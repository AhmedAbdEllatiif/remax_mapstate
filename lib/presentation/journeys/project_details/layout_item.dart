import 'package:flutter/material.dart';

import '../../themes/theme_color.dart';

class LayoutItem extends StatelessWidget {
  final String layoutKey;
  final String value;

  const LayoutItem({Key? key, required this.layoutKey, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          layoutKey,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColor.absoluteTransparentGeeBung,
          ),
        ),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColor.fadeGeeBung,
          ),
        ),
      ],
    );
  }
}
