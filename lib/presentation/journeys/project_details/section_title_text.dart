import 'package:flutter/material.dart';

import '../../themes/theme_color.dart';

class SectionTitleText extends StatelessWidget {
  final String text;

  const SectionTitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
