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

  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get containsLowercase => contains(RegExp(r'[a-z]'));
  bool get containsSpecialCharacter => contains(RegExp(r'(?=.*?[!@#\$&*~])'));
  bool get containsNumber => contains(RegExp(r'(?=.*?[0-9])'));
  bool get matchEmail => RegExp( r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  bool get matchPhoneNumber => RegExp(r'^01[0125][0-9]{8}$').hasMatch(this);

}