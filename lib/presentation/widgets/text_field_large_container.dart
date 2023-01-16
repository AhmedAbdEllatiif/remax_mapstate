import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/app_text_form_field.dart';

import '../../common/constants/app_utils.dart';
import '../../common/constants/sizes.dart';
import '../../common/screen_utils/screen_util.dart';
import '../themes/theme_color.dart';

class TextFieldLargeContainer extends StatelessWidget {
  final AppTextFormField appTextField;

  const TextFieldLargeContainer({Key? key, required this.appTextField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: Sizes.dimen_8.h, horizontal: Sizes.dimen_5.w),
        constraints: BoxConstraints(
            //minHeight: ScreenUtil.screenHeight * 0.15,
            maxHeight: ScreenUtil.screenHeight * 0.5),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppUtils.cornerRadius)),
        child: appTextField);
  }
}
