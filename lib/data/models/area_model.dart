// To parse this JSON data, do
//
//     final areaModel = areaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';

List<AreaModel> listOfAreasFromJson(dynamic data) =>
    List<AreaModel>.from(data["regions"].map((x) => AreaModel.fromJson(x)));

/*class AreaModel {
  AreaModel({
    required this.data,
  });

  final Data data;

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class AreaModel {
  AreaModel({
    required this.regions,
  });

  final List<Region> regions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    regions: List<Region>.from(json["regions"].map((x) => Region.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "regions": List<dynamic>.from(regions.map((x) => x.toJson())),
  };
}*/

class AreaModel extends AreaEntity {
  AreaModel({
    required this.areaId,
    required this.englishName,
    required this.arabicName,
    required this.areaPriority,
  }) : super(
            id: areaId,
            priority: areaPriority,
            name: englishName.isNotEmpty
                ? englishName
                : arabicName.isNotEmpty
                    ? arabicName
                    : AppUtils.undefined);

  final String areaId;
  final String englishName;
  final String arabicName;
  final int areaPriority;

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        areaId: json["id"] ?? AppUtils.undefined,
        englishName: json["name"] ?? "",
        arabicName: json["arabicName"] ?? "",
        areaPriority: json["priority"] ?? -1,
      );
}
