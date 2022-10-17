// To parse this JSON data, do
//
//     final taxModel = taxModelFromJson(jsonString);

import 'dart:convert';

import 'package:remax_mapstate/domain/entities/filter_data_entity.dart';

FilterDataModel filterDataModelFromJson(dynamic data) =>
    FilterDataModel.fromJson(data);

class FilterDataModel extends FilterDataEntity {
  FilterDataModel({
    required this.regions,
    required this.finishing,
    required this.unitTypeNames,
    required this.layouts,
  }) : super(
          // cities
          cities: List<String>.from(
              regions.map((e) => e.name.isNotEmpty ? e.name : e.arabicName)),
          // finishingTypes
          finishingTypes: List<String>.from(
              finishing.map((e) => e.name.isNotEmpty ? e.name : e.arabicName)),
          // types
          types: List<String>.from(unitTypeNames
              .map((e) => e.name.isNotEmpty ? e.name : e.arabicName)),
          // layouts
          layouts: List<String>.from(
              layouts.map((e) => e.name.isNotEmpty ? e.name : e.arabicName)),
        );

  final List<FilterItemName> regions;
  final List<FilterItemName> finishing;
  final List<FilterItemName> unitTypeNames;
  final List<FilterItemName> layouts;

  factory FilterDataModel.fromJson(Map<String, dynamic> json) =>
      FilterDataModel(
        //==> regions
        regions: json["regions"] != null
            ? List<FilterItemName>.from(
                json["regions"].map((x) => FilterItemName.fromJson(x)))
            : [],

        //=> finishingTypes
        finishing: json["finishingTypes"] != null
            ? List<FilterItemName>.from(
                json["finishingTypes"].map((x) => FilterItemName.fromJson(x)))
            : [],

        //==> unitTypeNames
        unitTypeNames: json["unitTypeNames"] != null
            ? List<FilterItemName>.from(
                json["unitTypeNames"].map((x) => FilterItemName.fromJson(x)))
            : [],

        //==> layouts
        layouts: json["layouts"] != null
            ? List<FilterItemName>.from(
                json["layouts"].map((x) => FilterItemName.fromJson(x)))
            : [],
      );

  @override
  String toString() {
    return "RegionName : $regions";
  }
}

class FilterItemName {
  FilterItemName({
    required this.arabicName,
    required this.name,
  });

  final String arabicName;
  final String name;

  factory FilterItemName.fromJson(Map<String, dynamic> json) => FilterItemName(
        arabicName: json["arabicName"] ?? "",
        name: json["name"] ?? "",
      );

  @override
  String toString() {
    return "arabicName: $arabicName, \nenglishName: $name";
  }
}
