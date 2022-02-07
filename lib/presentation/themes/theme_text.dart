import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/material/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get _whiteHeadline6 => _poppinsTextTheme.headline6!.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteHeadline5 => _poppinsTextTheme.headline5!.copyWith(
    fontSize: Sizes.dimen_24.sp,
    color: Colors.white,
  );

  static TextStyle get _whiteSubTitle1 => _poppinsTextTheme.headline6!.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );


  static TextStyle get _whiteSubTitle2 => _poppinsTextTheme.headline6!.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white,
      );

  //violetHeadLine6
  static TextStyle get _whiteBodyText2 => _poppinsTextTheme.bodyText2!.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static TextStyle get _button => _poppinsTextTheme.button!.copyWith(
    fontSize: Sizes.dimen_14.sp,
    color: Colors.white,
  );


  static getTextTheme() => TextTheme(
        headline5: _whiteHeadline5,
        headline6: _whiteHeadline6,
        subtitle1: _whiteSubTitle1,
        subtitle2: _whiteSubTitle2,
        bodyText2: _whiteBodyText2,
        button: _button,
      );
}

extension ThemeTextExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 => subtitle1!.copyWith(
        color: AppColor.royalBlue,
        fontWeight: FontWeight.w600,
      );

  TextStyle get gerySubtitle1 => subtitle1!.copyWith(
    color: Colors.grey,
  );

  TextStyle get geryHeadLine6 => headline6!.copyWith(
    color: Colors.grey,
  );

  TextStyle get violetHeadLine6 => headline6!.copyWith(
    color: AppColor.violet,
  );

  TextStyle get vulcanBodyText2 => bodyText2!.copyWith(
    color: AppColor.vulcan,
  );
}
