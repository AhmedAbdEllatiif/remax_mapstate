import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/language_constants.dart';
import '../../../domain/entities/language_enitity.dart';
import '../../../domain/entities/params/no_params.dart';
import '../../../domain/use_cases/local_usecases/get_preferred_language.dart';
import '../../../domain/use_cases/local_usecases/update_language.dart';


part 'language_state.dart';

class LanguageCubit extends Cubit<Locale> {
  final GetPreferredLanguage getPreferredLanguage;
  final UpdateLanguage updateLanguage;

  LanguageCubit({
    required this.getPreferredLanguage,
    required this.updateLanguage,
  }) : super(
    Locale(LanguageConstants.supportedLanguages[0].code),
  );

  Future<void> toggleLanguage(LanguageEntity language) async {
    await updateLanguage(language.code);
    loadPreferredLanguage();
  }

  void loadPreferredLanguage() async {
    final response = await getPreferredLanguage(NoParams());
    emit(response.fold(
          (l) => Locale(LanguageConstants.supportedLanguages[0].code),
          (r) => Locale(r),
    ));
  }
}