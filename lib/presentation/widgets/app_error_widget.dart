import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../common/constants/sizes.dart';
import '../../common/screen_utils/screen_util.dart';
import '../../domain/entities/app_error.dart';
import '../themes/theme_color.dart';
import 'app_button.dart';

class AppErrorWidget extends StatelessWidget {
  final AppErrorType appTypeError;
  final String message;
  final IconData? iconData;
  final String? buttonText;
  final Function() onPressedRetry;
  final bool withCard;

  const AppErrorWidget({
    Key? key,
    required this.appTypeError,
    this.message = '',
    required this.onPressedRetry,
    this.iconData,
    this.buttonText,
    this.withCard = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil.screenWidth * 0.80,
      child: withCard ? Card(
        color: AppColor.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.dimen_32.w, vertical: Sizes.dimen_5.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// Icon
              Icon(
                iconData ??
                    (appTypeError == AppErrorType.api
                        ? Icons.wifi_off_outlined
                        : Icons.warning_amber_outlined),
                color: AppColor.geeBung,
                size: Sizes.dimen_64.w,
              ),

              /// Text
              Text(
                message.isEmpty
                    ? appTypeError == AppErrorType.unAuthorized
                    ? TranslateConstants.sessionExpired.t(context)
                    : appTypeError == AppErrorType.api
                    ? TranslateConstants.retry.t(context)
                    : TranslateConstants.somethingWentWrong.t(context)
                    : message,
                textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: AppColor.black),
              ),

              /// Button
              Container(
                margin: EdgeInsets.symmetric(vertical: Sizes.dimen_5.h),
                child: AppButtonGradient(
                  text: buttonText ?? TranslateConstants.retry.t(context),
                  onPressed: onPressedRetry,
                ),
              ),
            ],
          ),
        ),
      ) : Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_32.w, vertical: Sizes.dimen_5.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Icon
            Icon(
              iconData ??
                  (appTypeError == AppErrorType.api
                      ? Icons.wifi_off_outlined
                      : Icons.warning_amber_outlined),
              color: AppColor.geeBung,
              size: Sizes.dimen_64.w,
            ),

            /// Text
            Text(
              message.isEmpty
                  ? appTypeError == AppErrorType.unAuthorized
                  ? TranslateConstants.sessionExpired.t(context)
                  : appTypeError == AppErrorType.api
                  ? TranslateConstants.retry.t(context)
                  : TranslateConstants.somethingWentWrong.t(context)
                  : message,
              textAlign: TextAlign.center,
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: withCard ? AppColor.black: AppColor.white),
            ),

            /// Button
            Container(
              margin: EdgeInsets.symmetric(vertical: Sizes.dimen_5.h),
              child: AppButtonGradient(
                text: buttonText ?? TranslateConstants.retry.t(context),
                onPressed: onPressedRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
