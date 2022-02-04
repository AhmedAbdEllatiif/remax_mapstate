import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/language_enitity.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageChanged(locale: Locale("en"))) {
    on<LanguageEvent>((event, emit) {

      if (event is ToggleLanguageEvent){
        emit(LanguageChanged(locale: Locale(event.languageEntity.code)));
      }

    });
  }
}
