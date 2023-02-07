import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/data/models/filter_model.dart';

import '../../../../common/enums/app_language.dart';
import '../../../../domain/entities/params/advanced_filter_builder.dart';
import '../language/language_cubit.dart';

part 'search_filter_builder_state.dart';

class SearchFilterBuilderCubit extends Cubit<SearchFilterBuilderState> {
  SearchFilterBuilderCubit() : super(AdvancedFilterBuilderInitial());

  // to build filters
  void buildFilters(
    BuildContext context, {
    String? type,
    String? city,
    String? finishingType,
    String? unitType,
    String? deliveryDate,
    double? priceFrom,
    double? priceTo,
    double? areaFrom,
    double? areaTo,
  }) {
    // reset to emit the same if required
    reset();

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

    _emitIfNotClosed(FiltersBuiltSuccessfully(filtersToAdd: filters));
  }

  void buildByArea(
    BuildContext context, {
    required String type,
    required String city,
    required String unitType,
  }) {
    // reset to emit the same if required
    reset();

    // init current language
    final languageCode = context.read<LanguageCubit>().state.languageCode;
    final appLanguage = languageCode == "en" ? AppLanguage.en : AppLanguage.ar;

    final filters = AdvancedProjectsFilterBuilder(
      appLanguage: appLanguage,
      type: type,
      city: city,
      unitType: unitType,
    ).build();

    _emitIfNotClosed(FiltersBuiltSuccessfully(filtersToAdd: filters));
  }

  /// reset the state
  void reset() {
    _emitIfNotClosed(AdvancedFilterBuilderInitial());
  }

  /// emit if not closed
  void _emitIfNotClosed(SearchFilterBuilderState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
