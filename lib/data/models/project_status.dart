import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';

import '../../common/constants/assets_constants.dart';

List<ProjectStatusModel> listOfProjectStatusFromJson(dynamic data) =>
    List<ProjectStatusModel>.from(
        data["projectStatuses"].map((x) => ProjectStatusModel.fromJson(x)));

class ProjectStatusModel extends ProjectStatusEntity {
  final String statusId;
  final String statusName;
  final String statusArabicName;
  final String statusImage;

  ProjectStatusModel({
    required this.statusId,
    required this.statusName,
    required this.statusArabicName,
    required this.statusImage,
  }) : super(
          id: statusId,
          name: statusName.isNotEmpty
              ? statusName
              : statusArabicName.isNotEmpty
                  ? statusArabicName
                  : AppUtils.undefined,
          image: statusImage,
        );

  factory ProjectStatusModel.fromJson(Map<String, dynamic> json) =>
      ProjectStatusModel(
        statusId: json["id"] ?? AppUtils.undefined,
        statusName: json["name"] ?? "",
        statusArabicName: json["arabicName"] ?? "",
        statusImage: json["arabicName"]!=null?
            json["arabicName"] == "تحت الانشاء"
            ? AssetsConstants.underConstructionImg
            : json["arabicName"] == "عروض"
            ? AssetsConstants.offers
            : json["arabicName"] == "فرص استثمارية"
            ? AssetsConstants.investment
            : json["arabicName"] == "استلام فوري"
            ? AssetsConstants.readyToMoveImg
            : json["arabicName"] == "رسومات فقط"
            ? AssetsConstants.offPlanImg
            : AssetsConstants.underConstructionImg:


            json["name"] == "Under Construction"
            ? AssetsConstants.underConstructionImg
            : json["name"] == "Offers"
                ? AssetsConstants.offers
                : json["name"] == "Oppurtunities"
                    ? AssetsConstants.investment
                    : json["name"] == "Ready To Move"
                        ? AssetsConstants.readyToMoveImg
                        : json["name"] == "Off Plan"
                            ? AssetsConstants.offPlanImg
                            : AssetsConstants.underConstructionImg,
      );
}
