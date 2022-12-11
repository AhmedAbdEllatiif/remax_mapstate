import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/data/models/filter_model.dart';

import '../../../../common/enums/app_language.dart';
import '../../../../domain/entities/params/advanced_filter_builder.dart';
import '../language/language_cubit.dart';

part 'advanced_filter_builder_state.dart';

class AdvancedFilterBuilderCubit extends Cubit<AdvancedFilterBuilderState> {
  AdvancedFilterBuilderCubit() : super(AdvancedFilterBuilderInitial());

  void reset() {
    if (!isClosed) {
      emit(AdvancedFilterBuilderInitial());
    }
  }

  void addFilters(
    BuildContext context, {
    required String type,
    required String city,
    required String finishingType,
    required String unitType,
    required String deliveryDate,
    double? priceFrom,
    double? priceTo,
    double? areaFrom,
    double? areaTo,
  }) {
    // init current language
    final languageCode = context.read<LanguageCubit>().state.languageCode;
    final appLanguage = languageCode == "en" ? AppLanguage.en : AppLanguage.ar;

    final filters = AdvancedProjectsFilterBuilder(
      appLanguage: appLanguage,
      type: type,
      city: city,
      finishingType: finishingType,
      unitType: unitType,
      deliveryDate: deliveryDate,
      priceFrom: priceFrom,
      priceTo: priceTo,
      areaFrom: areaFrom,
      areaTo: areaTo,
    ).build();

    if (!isClosed) {
      emit(FiltersToAdd(filtersToAdd: filters));
    }
  }
}
