import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class SubmitInquiryButton extends StatelessWidget {

  final Function() onPressed;

  const SubmitInquiryButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.dimen_18.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.vulcan,
            AppColor.royalBlue,
            AppColor.vulcan
          ],
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          TranslateConstants.submitInquiry.t(context),
          style: Theme.of(context).textTheme.submitTextButton,
        ),
      ),
    );
  }
}
