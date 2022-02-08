import 'package:flutter/cupertino.dart';
import 'package:remax_mapstate/presentation/app_localization.dart';

extension StringExtension on String {
  String intelliTrim() {
    return length > 15 ? '${substring(0, 15)}...' : this;
  }

  String intelliTrim_14() {
    return length > 14 ? '${substring(0, 14)}...' : this;
  }

  String t(BuildContext context){
    return AppLocalizations.of(context).translate(this);
  }

}