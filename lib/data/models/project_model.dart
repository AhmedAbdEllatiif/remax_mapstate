// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);
//     final projects = listOfProjectModel(map<String,dynamic>);

import 'dart:convert';

import 'package:remax_mapstate/domain/entities/project_entity.dart';

List<ProjectModel> listOfProjectModel(Map<String, dynamic> json) =>
    List<ProjectModel>.from(
        json["projects"].map((x) => ProjectModel.fromJson(x)));

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

//String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required this.projectId,
    required this.projectName,
    required this.projectArabicName,
    required this.projectDescription,
    required this.projectDescriptionArabic,
    required this.projectPriceFrom,
    required this.projectAreaFrom,
    required this.projectDeliveryYear,
    required this.projectType,
    required this.projectStatus,
    required this.projectRegion,
    required this.projectZone,
    required this.projectServices,
    required this.projectUnitTypeSet,
    required this.projectPaymentPlan,
    required this.projectLocation,
    required this.projectDeveloper,
  }) : super(
    id: projectId ?? "",
    name: projectName,
    arabicName: projectArabicName,
    description: projectDescription,
    descriptionArabic: projectDescriptionArabic,
    priceFrom: projectPriceFrom,
    areaFrom: projectAreaFrom,
    deliveryYear: projectDeliveryYear,
    type: projectType,
    status: projectStatus,
    region: projectRegion,
    zone: projectZone,
    services: projectServices,
    unitTypeSet: projectUnitTypeSet,
    paymentPlan: projectPaymentPlan,
    location: projectLocation ?? "",
    developer: projectDeveloper,
  );

  final String? projectId;
  final String projectName;
  final String projectArabicName;
  final String projectDescription;
  final String projectDescriptionArabic;
  final String projectPriceFrom;
  final String projectAreaFrom;
  final String projectDeliveryYear;
  final ProjectType projectType;
  final DifferentLanguages projectStatus;
  final DifferentLanguages projectRegion;
  final DifferentLanguages projectZone;
  final List<DifferentLanguages> projectServices;
  final List<UnitTypeSet> projectUnitTypeSet;
  final PaymentPlan projectPaymentPlan;
  final dynamic projectLocation;
  final Developer projectDeveloper;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
    projectId: json["id"],

    // name
    projectName: json["name"] ?? "",

    // arabicName
    projectArabicName: json["arabicName"] ?? "",

    // description
    projectDescription: json["description"] ?? "",

    // descriptionArabic
    projectDescriptionArabic: json["descriptionArabic"] ?? "",

    // priceFrom
    projectPriceFrom: json["priceFrom"] ?? "",

    // areaFrom
    projectAreaFrom: json["areaFrom"] ?? "",

    // deliveryYear
    projectDeliveryYear: json["deliveryYear"] ?? "",

    // type
    projectType: json["type"] != null
        ? typeValues.map[json["type"]] ?? ProjectType.unDefined
        : ProjectType.unDefined,

    // status
    projectStatus: json["status"] != null
        ? DifferentLanguages.fromJson(json["status"])
        : DifferentLanguages.empty(),

    // region
    projectRegion: json["region"] != null
        ? DifferentLanguages.fromJson(json["region"])
        : DifferentLanguages.empty(),

    // zone
    projectZone: json["zone"] != null
        ? DifferentLanguages.fromJson(json["zone"])
        : DifferentLanguages.empty(),

    // services
    projectServices: json["services"] != null
        ? List<DifferentLanguages>.from(
        json["services"].map((x) => DifferentLanguages.fromJson(x)))
        : [],

    // UnitTypeSet
    projectUnitTypeSet: json["unittypeSet"] != null
        ? List<UnitTypeSet>.from(
        json["unittypeSet"].map((x) => UnitTypeSet.fromJson(x)))
        : [],

    // PaymentPlan
    projectPaymentPlan: json["paymentplan"] != null
        ? PaymentPlan.fromJson(json["paymentplan"])
        : PaymentPlan.empty(),
    projectLocation: json["location"],

    // developer
    projectDeveloper: json["developer"] != null
        ? Developer.fromJson(json["developer"])
        : Developer.empty(),
  );

/* Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "arabicName": arabicName,
    "description": description,
    "descriptionArabic": descriptionArabic,
    "priceFrom": priceFrom,
    "areaFrom": areaFrom,
    "deliveryYear": deliveryYear,
    "type": typeValues.reverse[type],
    "status": status.toJson(),
    "region": region.toJson(),
    "zone": zone == null ? null : zone.toJson(),
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
    "unittypeSet": List<dynamic>.from(unittypeSet.map((x) => x.toJson())),
    "paymentplan": paymentplan.toJson(),
    "location": location,
    "developer": developer.toJson(),
  };*/
}

class Developer extends DeveloperEntity {
  const Developer({
    required this.developerName,
  }) : super(name: developerName ?? "Undefined");

  final String? developerName;

  factory Developer.empty() => const Developer(
    developerName: "Undefined",
  );

  factory Developer.fromJson(Map<String, dynamic> json) => Developer(
    developerName: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": developerName,
  };
}

class PaymentPlan extends PaymentPlanEntity {
  const PaymentPlan({
    required this.planPercentage,
    required this.planNumberOfYears,
  }) : super(
    percentage: planPercentage ?? 0,
    numberOfYears: planNumberOfYears ?? 0,
  );

  final int? planPercentage;
  final int? planNumberOfYears;

  factory PaymentPlan.fromJson(Map<String, dynamic> json) => PaymentPlan(
    planPercentage: json["percentage"],
    planNumberOfYears: json["numberOfYears"],
  );

  factory PaymentPlan.empty() => const PaymentPlan(
    planPercentage: 0,
    planNumberOfYears: 0,
  );

  Map<String, dynamic> toJson() => {
    "percentage": planPercentage,
    "numberOfYears": planNumberOfYears,
  };
}

enum ProjectType { commercial, residential, unDefined }

final typeValues = EnumValues({
  "COMMERCIAL": ProjectType.commercial,
  "RESIDENTIAL": ProjectType.residential,
  "UNDEFINED": ProjectType.unDefined
});

class DifferentLanguages extends DifferentLanguagesEntity {
  const DifferentLanguages({
    required this.langName,
    required this.langArabicName,
  }) : super(
      name: langName ?? "unDefined",
      arabicName: langArabicName ?? "غير معروف");

  final String? langName;
  final String? langArabicName;

  factory DifferentLanguages.empty() => const DifferentLanguages(
    langName: "unDefined",
    langArabicName: "غير معروف",
  );

  factory DifferentLanguages.fromJson(Map<String, dynamic> json) =>
      DifferentLanguages(
        langName: json["name"],
        langArabicName: json["arabicName"],
      );

  Map<String, dynamic> toJson() => {
    "name": langName,
    "arabicName": langArabicName,
  };
}

class UnitTypeSet extends UnitTypeSetEntity {
  UnitTypeSet({
    required this.name,
    required this.unitLayout,
    required this.unitPriceFrom,
    required this.unitAreaFrom,
    required this.unitPercentage,
    required this.unitFinishingType,
  }) : super(
    unitTypeName: name ?? DifferentLanguages.empty(),
    layout: DifferentLanguages.empty(),
    priceFrom: unitPriceFrom ?? "unDefined",
    areaFrom: unitAreaFrom ?? "unDefined",
    percentage: unitPercentage ?? 0,
    finishingType: unitFinishingType ?? DifferentLanguages.empty(),
  );

  final DifferentLanguages? name;
  final DifferentLanguages? unitLayout;
  final String? unitPriceFrom;
  final String? unitAreaFrom;
  final int? unitPercentage;
  final DifferentLanguages? unitFinishingType;

  factory UnitTypeSet.fromJson(Map<String, dynamic> json) => UnitTypeSet(
    name: DifferentLanguages.fromJson(json["unitTypeName"]),
    unitLayout: json["layout"] != null
        ? DifferentLanguages.fromJson(json["layout"])
        : DifferentLanguages.empty(),
    unitPriceFrom: json["priceFrom"],
    unitAreaFrom: json["areaFrom"],
    unitPercentage: json["percentage"],
    unitFinishingType: DifferentLanguages.fromJson(json["finishingType"]),
  );

/*Map<String, dynamic> toJson() => {
    "unitTypeName": unitTypeName.toJson(),
    "layout": layout == null ? null : layout.toJson(),
    "priceFrom": priceFrom,
    "areaFrom": areaFrom,
    "percentage": percentage,
    "finishingType": finishingType.toJson(),
  };*/
}

class EnumValues<T> {
  Map<String, T> map;

  EnumValues(this.map);
}
