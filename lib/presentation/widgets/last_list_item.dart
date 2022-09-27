import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes/theme_color.dart';

class LastListItem extends StatelessWidget {

  const LastListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "...",
      style: Theme.of(context)
          .textTheme
          .headline5!
          .copyWith(color: AppColor.white,fontWeight: FontWeight.bold),
    );
  }
}
