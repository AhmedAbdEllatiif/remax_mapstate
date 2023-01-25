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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            layoutKey,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style:  TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        Center(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }
}
