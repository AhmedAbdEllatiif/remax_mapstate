import 'package:remax_mapstate/common/constatns/translate_constatns.dart';
import 'package:remax_mapstate/domain/entities/language_enitity.dart';



class LanguageConstants{
  const LanguageConstants._();

  static const supportedLanguages = [
    LanguageEntity(code: 'en', value: TranslateConstants.english),
    LanguageEntity(code: 'ar', value: TranslateConstants.arabic),
  ];

}