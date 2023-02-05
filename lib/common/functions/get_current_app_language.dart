import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/app_language.dart';

import '../../presentation/logic/cubit/language/language_cubit.dart';

AppLanguage getCurrentAppLanguage(BuildContext context){
  // init current language
  final languageCode = context.read<LanguageCubit>().state.languageCode;
  return languageCode == "en" ? AppLanguage.en : AppLanguage.ar;
}