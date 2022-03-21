import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../../../../common/constants/language_constants.dart';
import '../../../../common/constants/translate_constatns.dart';
import '../../../cubit/language/language_cubit.dart';

class ToggleLanguageWidget extends StatelessWidget {
  const ToggleLanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => toggleLanguage(
            context: context,
            currentLanguage: state.languageCode,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.language_outlined,
                color: AppColor.geeBung,
              ),
              Text(
                " ${getLanguageCodeToChange(
                  context: context,
                  currentLanguage: state.languageCode,
                )}",
                style: const TextStyle(color: AppColor.geeBung),
              )
            ],
          ),
        );
      },
    );
  }

  /// return a string of the other language to change to
  String getLanguageCodeToChange(
      {required BuildContext context, required String currentLanguage}) {
    return currentLanguage == LanguageConstants.supportedLanguages[0].code
        ? TranslateConstants.arabic.t(context)
        : TranslateConstants.english.t(context).toUpperCase();
  }

  /// To change the current language
  void toggleLanguage(
      {required BuildContext context, required String currentLanguage}) {
    if (currentLanguage == LanguageConstants.supportedLanguages[0].code) {
      /// change to Arabic
      context
          .read<LanguageCubit>()
          .toggleLanguage(LanguageConstants.supportedLanguages[1]);
    } else {
      /// change to English
      context
          .read<LanguageCubit>()
          .toggleLanguage(LanguageConstants.supportedLanguages[0]);
    }
  }

  /// return true if the current language is english
  bool isEnglishLanguage(String currentLanguage) =>
      currentLanguage == LanguageConstants.supportedLanguages[0].code;
}
