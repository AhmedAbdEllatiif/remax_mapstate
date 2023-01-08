import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/widgets/app_dialog.dart';

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