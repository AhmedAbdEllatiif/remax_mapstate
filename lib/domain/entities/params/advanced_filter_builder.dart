import 'package:equatable/equatable.dart';

import '../../../common/enums/app_language.dart';
import '../../../common/enums/filter_clause.dart';
import '../../../data/models/filter_model.dart';

class AdvancedProjectsFilterBuilder extends Equatable {
  final AppLanguage appLanguage;
  final String type;
  final String city;
  final String finishingType;
  final String unitType;
  final String deliveryDate;
  final double? priceFrom;
  final double? priceTo;
  final double? areaFrom;
  final double? areaTo;

  const AdvancedProjectsFilterBuilder({
    required this.appLanguage,
    required this.type,
    required this.city,
    required this.finishingType,
    required this.unitType,
    required this.deliveryDate,
    required this.priceFrom,
    required this.priceTo,
    required this.areaFrom,
    required this.areaTo,
  });

  /// to build filter according to current app language
  List<FilterModel> build() =>
      appLanguage == AppLanguage.en ? _englishFilters() : _arabicFilters();

  ///  to build list of filters in arabic
  List<FilterModel> _arabicFilters() {
    final List<FilterModel> filters = [];
    // type
    //filters.add(FilterModel(field: "type", value: type));
    // city
    filters.add(FilterModel(field: "region__arabic_name", value: city));
    // finishingType
    filters.add(FilterModel(
      field: "finishing_type__arabic_name",
      value: finishingType,
    ));
    // unitType
    /*filters.add(FilterModel(
      field: "finishing_type__name",
      value: finishingType,
    ));*/

    filters.add(FilterModel(
      field: "delivery_year",
      value: deliveryDate,
    ));

    //==> priceForm
    if (priceFrom != null) {
      filters.add(FilterModel(
          field: "price_from", value: priceFrom, clause: FilterClause.gte));
    }

    //==> priceTo
    if (priceFrom != null) {
      filters.add(FilterModel(
          field: "price_from", value: priceTo, clause: FilterClause.lte));
    }

    //==> areaForm
    if (areaFrom != null) {
      filters.add(FilterModel(
          field: "area_from", value: areaFrom, clause: FilterClause.gte));
    }
    //==> areaTo
    if (areaTo != null) {
      filters.add(FilterModel(
          field: "area_from", value: areaTo, clause: FilterClause.lte));
    }

    return filters;
  }

  ///  to build list of filters in english
  List<FilterModel> _englishFilters() {
    final List<FilterModel> filters = [];
    // type
    //filters.add(FilterModel(field: "type", value: type));
    // city
    filters.add(FilterModel(field: "region__name", value: city));
    // finishingType
    filters.add(FilterModel(
      field: "finishing_type__name",
      value: finishingType,
    ));
    // unitType
    /*filters.add(FilterModel(
      field: "finishing_type__name",
      value: finishingType,
    ));*/

    filters.add(FilterModel(
      field: "delivery_year",
      value: deliveryDate,
    ));

    //==> priceForm
    if (priceFrom != null) {
      filters.add(FilterModel(
          field: "price_from", value: priceFrom, clause: FilterClause.gte));
    }

    //==> priceTo
    if (priceFrom != null) {
      filters.add(FilterModel(
          field: "price_from", value: priceTo, clause: FilterClause.lte));
    }

    //==> areaForm
    if (areaFrom != null) {
      filters.add(FilterModel(
          field: "area_from", value: areaFrom, clause: FilterClause.gte));
    }
    //==> areaTo
    if (areaTo != null) {
      filters.add(FilterModel(
          field: "area_from", value: areaTo, clause: FilterClause.lte));
    }

    return filters;
  }

  @override
  List<Object?> get props => [
        appLanguage,
        type,
        city,
        finishingType,
        unitType,
        deliveryDate,
        priceFrom,
        priceTo,
        areaFrom,
        areaTo,
      ];
}
