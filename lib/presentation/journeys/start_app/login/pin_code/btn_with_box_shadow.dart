import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../../../common/constants/sizes.dart';
import '../../../../themes/theme_color.dart';

class ButtonWithBoxShadow extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const ButtonWithBoxShadow({Key? key,required this.onPressed,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
      child: ButtonTheme(
        height: Sizes.dimen_24.h,
        child: TextButton(
          onPressed: onPressed,
          child: Center(
              child: Text(
                  text,
                style: Theme.of(context).textTheme.buttonText.copyWith(fontSize:  Sizes.dimen_18.sp),
              )),
        ),
      ),
      decoration: BoxDecoration(
          color: AppColor.vulcan,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
                color: AppColor.vulcan,
                offset: Offset(1, -2),
                blurRadius: 5),
            BoxShadow(
                color: AppColor.vulcan,
                offset: Offset(-1, 2),
                blurRadius: 5)
          ]),
    );
  }
}
