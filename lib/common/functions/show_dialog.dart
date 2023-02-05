import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../presentation/themes/theme_color.dart';
import '../../presentation/widgets/app_dialog.dart';
import '../constants/sizes.dart';
import '../constants/translate_constatns.dart';

/// To show  dialog
void showAppDialog(BuildContext context,
    {String? message,
    String? buttonText,
    Function()? onPressed,
    Widget? image,
    bool isLoadingDialog = false}) {
  showDialog(
    context: context,
    builder: (context) {
      return AppDialog(
        description: message ?? "",
        buttonText: buttonText ?? "",
        onPressed: onPressed,
        isLoadingDialog: isLoadingDialog,
        image: image,
      );
    },
  );
}

/// to show success dialog
void showSuccessDialog(BuildContext context, {required String message}) {
  showAppDialog(
    context,
    image: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.black),
        ),
        child: Icon(
          Icons.done_all,
          size: Sizes.dimen_40.w,
        )),
    message: message,
    buttonText: TranslateConstants.okay.t(context),
  );
}
