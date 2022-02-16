import 'dart:async';

import 'package:hive/hive.dart';

abstract class AppSettingsLocalDataSource{


  /// update current preferred language
  Future<void> updateLanguage(String languageCode);

  /// return the current preferred language
  Future<String> getPreferredLanguage();

}


class AppSettingsLocalDataSourceImpl extends AppSettingsLocalDataSource{

  /// return the current preferred language
  /// return 'en' as default if no language box in local DB
  @override
  Future<String> getPreferredLanguage() async {
    final languageBox = await Hive.openBox('languageBox');
    return languageBox.get('preferred_language') ?? 'en';
  }

  /// update current preferred language
  @override
  Future<void> updateLanguage(String languageCode) async {
    final languageBox = await Hive.openBox('languageBox');
    unawaited(languageBox.put('preferred_language', languageCode));
  }

}