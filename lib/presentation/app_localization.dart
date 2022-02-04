import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remax_mapstate/common/constatns/assets_constants.dart';
import 'package:remax_mapstate/common/constatns/language_constants.dart';

class AppLocalizations {
  final Locale locale;


  static AppLocalizations of(context) => Localizations.of<AppLocalizations>(context, AppLocalizations)!;


  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationDelegate();

  AppLocalizations({required this.locale});

  late Map<String,String> _localizedStrings;

  Future<bool> load() async{
    final jsonString = await rootBundle.loadString('${AssetsConstants.languagesPath}${locale.languageCode}.json');
    final Map<String,dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) => MapEntry<String,String>(key,value.toString()));

    return true;
  }


  String translate(String key){
    return _localizedStrings[key]!;
  }
}


class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return LanguageConstants.supportedLanguages
        .map((e) => e.code)
        .toList()
        .contains(locale.languageCode);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async{
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }
}
