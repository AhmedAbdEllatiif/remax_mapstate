import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/domain/entities/unit_type_entity.dart';


List<UnitTypeModel> listOfUnitTypeNamesFromJson(dynamic data) =>
    List<UnitTypeModel>.from(data["unitTypeNames"].map((x) => UnitTypeModel.fromJson(x)));

class UnitTypeModel extends UnitTypeEntity {
  final String unitTypeId;
  final String unitTypeName;
  final String unitTypeArabicName;
  final bool unitTypeIsCommercial;
  final int unitTypePriority;

  UnitTypeModel({
    required this.unitTypeId,
    required this.unitTypeName,
    required this.unitTypeArabicName,
    required this.unitTypeIsCommercial,
    required this.unitTypePriority,
  }) : super(
            id: unitTypeId,
            name: unitTypeName.isNotEmpty
                ? unitTypeName
                : unitTypeArabicName.isNotEmpty
                    ? unitTypeArabicName
                    : AppUtils.undefined,
            isCommercial: unitTypeIsCommercial,
            priority: unitTypePriority);

  factory UnitTypeModel.fromJson(Map<String, dynamic> json) => UnitTypeModel(
        unitTypeId: json["id"] ?? AppUtils.undefined,
        unitTypeName: json["name"] ?? "",
        unitTypeArabicName: json["arabicName"] ?? "",
        unitTypeIsCommercial: json["isCommercial"] ?? false,
        unitTypePriority: json["priority"] ?? -1,
      );
}
