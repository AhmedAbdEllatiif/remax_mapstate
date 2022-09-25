import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/app_language.dart';
import 'package:remax_mapstate/data/params/fetch_areas_params.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_areas.dart';

import '../../../../domain/entities/params/no_params.dart';
import '../language/language_cubit.dart';

part 'areas_state.dart';

class AreasCubit extends Cubit<AreasState> {
  final GetAreasCase getAreas;

  AreasCubit({required this.getAreas}) : super(LoadingAreas());

  /// fetch areas
  void fetchAreas(BuildContext context, {int limit = 6}) async {
    // init current language
    final languageCode = context.read<LanguageCubit>().state.languageCode;
    final appLanguage = languageCode == "en" ? AppLanguage.en : AppLanguage.ar;

    _emitIfNotClosed(LoadingAreas());

    final response = await getAreas(
        FetchAreaParams(limit: limit, orderBy: "id", appLanguage: appLanguage));
    response.fold(
      (appError) =>
          _emitIfNotClosed(ErrorWhileLoadingAreas(appError: appError)),
      (areas) => _emitIfNotClosed(AreasFetched(areas: areas)),
    );
  }

  /// emit if not closed
  void _emitIfNotClosed(AreasState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
