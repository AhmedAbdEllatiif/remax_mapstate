// To parse this JSON data, do
//
//     final projectModel = projectModelFromJson(jsonString);
//     final projects = listOfProjectModel(map<String,dynamic>);

import 'dart:convert';

import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';

List<ProjectModel> listOfProjectModel(Map<String, dynamic> json) =>
    List<ProjectModel>.from(
        json["projects"].map((x) => ProjectModel.fromJson(x)));

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

//String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel extends ProjectEntity {
  ProjectModel({
    required this.projectId,
    required this.projectName,
    required this.projectArabicName,
    required this.projectDescription,
    required this.projectDescriptionArabic,
    required this.projectType,
    required this.projectPriceFrom,
    required this.projectAreaFrom,
    required this.projectDeliveryYear,
    required this.projectDeliveryMonth,
    required this.projectStatus,
    required this.projectRegion,
    required this.projectZone,
    required this.projectServices,
    required this.projectUnitTypeSet,
    required this.projectPaymentPlan,
    required this.projectLocation,
    required this.projectDeveloper,
  }) : super(
          id: projectId,
          name: projectName.isNotEmpty
              ? projectName
              : projectArabicName.isNotEmpty
                  ? projectArabicName
                  : AppUtils.undefined,
          description: projectDescription.isNotEmpty
              ? projectDescription
              : projectDescriptionArabic.isNotEmpty
                  ? projectDescriptionArabic
                  : AppUtils.undefined,
          priceFrom: projectPriceFrom,
          areaFrom: projectAreaFrom,
          deliveryYear: projectDeliveryYear,
          deliveryMonth: projectDeliveryMonth,
          type: projectType,

          //==> finishingType
          /*finishingType: projectFinishingType.name.isNotEmpty
              ? projectFinishingType.name
              : projectFinishingType.arabicName.isNotEmpty
                  ? projectFinishingType.arabicName
                  : AppUtils.undefined,*/

          //==> status
          status: projectStatus.name.isNotEmpty
              ? projectStatus.name
              : projectStatus.arabicName.isNotEmpty
                  ? projectStatus.arabicName
                  : AppUtils.undefined,

          //==> region
          region: projectRegion.name.isNotEmpty
              ? projectRegion.name
              : projectRegion.arabicName.isNotEmpty
                  ? projectRegion.arabicName
                  : AppUtils.undefined,

          //==> zone
          zone: projectZone.name.isNotEmpty
              ? projectZone.name
              : projectZone.arabicName.isNotEmpty
                  ? projectZone.arabicName
                  : AppUtils.undefined,

          //==> services
          services: projectServices
              .map((service) => service.name.isNotEmpty
                  ? service.name
                  : service.arabicName.isNotEmpty
                      ? service.arabicName
                      : AppUtils.undefined)
              .toList(),

          unitTypeSets: projectUnitTypeSet,
          planPercentage: projectPaymentPlan.planPercentage,
          planNumberOfYears: projectPaymentPlan.planNumberOfYears,
          location: projectLocation,
          developer: projectDeveloper,
        );

  final String projectId;
  final String projectName;
  final String projectArabicName;
  final String projectDescription;
  final String projectDescriptionArabic;
  final String projectPriceFrom;
  final String projectAreaFrom;
  final String projectDeliveryYear;
  final String projectDeliveryMonth;
  final ProjectType projectType;
  final ProjectStatus projectStatus;
  final Region projectRegion;
  final Zone projectZone;
  final List<ProjectService> projectServices;
  final List<UnitTypeSet> projectUnitTypeSet;
  final PaymentPlan projectPaymentPlan;
  final LocationModel projectLocation;
  final DeveloperModel projectDeveloper;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        projectId: json["id"] ?? AppUtils.undefined,

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

        // deliveryYear
        projectDeliveryMonth: json["deliveryMonth"] ?? "",

        // type
        projectType: json["type"] != null
            ? typeValues.map[json["type"]] ?? ProjectType.unDefined
            : ProjectType.unDefined,

        /*// finishingType
        projectFinishingType: json["finishingType"] != null
            ? FinishingType.fromJson(json["finishingType"])
            : FinishingType.empty(),*/

        // status
        projectStatus: json["status"] != null
            ? ProjectStatus.fromJson(json["status"])
            : ProjectStatus.empty(),

        // region
        projectRegion: json["region"] != null
            ? Region.fromJson(json["region"])
            : Region.empty(),

        // zone
        projectZone:
            json["zone"] != null ? Zone.fromJson(json["zone"]) : Zone.empty(),

        // services
        projectServices: json["services"] != null
            ? List<ProjectService>.from(
                json["services"].map((x) => ProjectService.fromJson(x)))
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

        projectLocation: json["location"] != null
            ? LocationModel.fromJson(json["location"])
            : LocationModel.empty(),

        // developer
        projectDeveloper: json["developer"] != null
            ? DeveloperModel.fromJson(json["developer"])
            : DeveloperModel.empty(),
      );
}

/// Developer
class DeveloperModel extends DeveloperEntity {
  DeveloperModel(
      {required this.developerId,
      required this.developerName,
      required this.developerArabicName,
      required this.developerLogo,
      required this.developerContact,
      required this.developerLocation})
      : super(
          id: developerId,
          name: developerName.isNotEmpty
              ? developerName
              : developerArabicName.isNotEmpty
                  ? developerArabicName
                  : AppUtils.undefined,
          logo: developerLogo,
          developerContactEntity: developerContact,
          locationEntity: developerLocation,
        );

  final String developerId;
  final String developerName;
  final String developerArabicName;
  final String developerLogo;
  final DeveloperContact developerContact;
  final LocationModel developerLocation;

  factory DeveloperModel.empty() => DeveloperModel(
        developerId: AppUtils.undefined,
        developerName: "",
        developerArabicName: "",
        developerLogo: AppUtils.undefined,
        developerContact: DeveloperContact.empty(),
        developerLocation: LocationModel.empty(),
      );

  factory DeveloperModel.fromJson(Map<String, dynamic> json) => DeveloperModel(
        developerId: json["id"] ?? AppUtils.undefined,
        developerName: json["name"] ?? "",
        developerArabicName: json["arabicName"] ?? "",
        developerLogo: json["logo"] ?? AppUtils.undefined,
        developerContact: json["developercontact"] != null
            ? DeveloperContact.fromJson(json["developercontact"])
            : DeveloperContact.empty(),
        developerLocation: json["location"] != null
            ? LocationModel.fromJson(json["location"])
            : LocationModel.empty(),
      );

  Map<String, dynamic> toJson() => {
        "name": developerName,
      };
}

class DeveloperContact extends DeveloperContactEntity {
  const DeveloperContact({
    required this.contactId,
    required this.contactFirstName,
    required this.contactLastName,
    required this.contactPhone,
    required this.contactImage,
  }) : super(
          id: contactId,
          firstName: contactFirstName,
          lastName: contactLastName,
          phone: contactPhone,
          image: contactImage,
        );

  final String contactId;
  final String contactFirstName;
  final String contactLastName;
  final String contactPhone;
  final String contactImage;

  factory DeveloperContact.empty() => const DeveloperContact(
        contactId: AppUtils.undefined,
        contactFirstName: AppUtils.undefined,
        contactLastName: AppUtils.undefined,
        contactPhone: AppUtils.undefined,
        contactImage: AppUtils.undefined,
      );

  factory DeveloperContact.fromJson(Map<String, dynamic> json) =>
      DeveloperContact(
        contactId: json["id"] ?? AppUtils.undefined,
        contactFirstName: json["firstName"] ?? AppUtils.undefined,
        contactLastName: json["lastName"] ?? AppUtils.undefined,
        contactPhone: json["phone"] ?? AppUtils.undefined,
        contactImage: json["personalImage"] ?? AppUtils.undefined,
      );
}

/// DeveloperLocation
class LocationModel extends LocationEntity {
  const LocationModel({
    required this.locationId,
    required this.text,
    required this.locationAddress,
    required this.locationGeometry,
  }) : super(
          id: locationId,
          locationText: text,
          address: locationAddress,
          geometry: locationGeometry,
        );
  final String locationId;
  final String text;
  final String locationAddress;
  final dynamic locationGeometry;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        locationId: json["id"] ?? AppUtils.undefined,
        text: json["locationText"] ?? AppUtils.undefined,
        locationAddress: json["address"] ?? AppUtils.undefined,
        locationGeometry: json["geometry"] ?? AppUtils.undefined,
      );

  factory LocationModel.empty() => const LocationModel(
        locationId: AppUtils.undefined,
        text: AppUtils.undefined,
        locationAddress: AppUtils.undefined,
        locationGeometry: AppUtils.undefined,
      );
}

/// PaymentPlan
class PaymentPlan {
  const PaymentPlan({
    required this.planPercentage,
    required this.planNumberOfYears,
  });

  final int planPercentage;
  final int planNumberOfYears;

  factory PaymentPlan.fromJson(Map<String, dynamic> json) => PaymentPlan(
        planPercentage: json["percentage"] ?? -1,
        planNumberOfYears: json["numberOfYears"] ?? -1,
      );

  factory PaymentPlan.empty() => const PaymentPlan(
        planPercentage: -1,
        planNumberOfYears: -1,
      );
}

/// projectStatus
class ProjectStatus {
  const ProjectStatus({
    required this.id,
    required this.name,
    required this.arabicName,
  });

  final String id;
  final String name;
  final String arabicName;

  factory ProjectStatus.fromJson(Map<String, dynamic> json) => ProjectStatus(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        arabicName: json["arabicName"] ?? AppUtils.undefined,
      );

  factory ProjectStatus.empty() => const ProjectStatus(
        id: AppUtils.undefined,
        name: "",
        arabicName: "",
      );
}

/// Region
class Region {
  const Region({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.priority,
  });

  final String id;
  final String name;
  final String arabicName;
  final int priority;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        arabicName: json["arabicName"] ?? AppUtils.undefined,
        priority: json["priority"] ?? -1,
      );

  factory Region.empty() => const Region(
        id: AppUtils.undefined,
        name: "",
        arabicName: "",
        priority: -1,
      );
}

/// Zone
class Zone {
  const Zone({
    required this.id,
    required this.name,
    required this.arabicName,
  });

  final String id;
  final String name;
  final String arabicName;

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        arabicName: json["arabicName"] ?? AppUtils.undefined,
      );

  factory Zone.empty() => const Zone(
        id: AppUtils.undefined,
        name: "",
        arabicName: "",
      );
}

/// Zone
class FinishingType {
  const FinishingType({
    required this.id,
    required this.name,
    required this.arabicName,
  });

  final String id;
  final String name;
  final String arabicName;

  factory FinishingType.fromJson(Map<String, dynamic> json) => FinishingType(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        arabicName: json["arabicName"] ?? AppUtils.undefined,
      );

  factory FinishingType.empty() => const FinishingType(
        id: AppUtils.undefined,
        name: "",
        arabicName: "",
      );
}

/// Service
class ProjectService {
  const ProjectService({
    required this.id,
    required this.name,
    required this.arabicName,
  });

  final String id;
  final String name;
  final String arabicName;

  factory ProjectService.fromJson(Map<String, dynamic> json) => ProjectService(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        arabicName: json["arabicName"] ?? AppUtils.undefined,
      );

  factory ProjectService.empty() => const ProjectService(
        id: AppUtils.undefined,
        name: "",
        arabicName: "",
      );
}

/// UnitTypeSet
class UnitTypeSet extends UnitTypeSetEntity {
  UnitTypeSet({
    required this.unitTypeName,
    required this.unitLayout,
    required this.unitPriceFrom,
    required this.unitPriceTo,
    required this.unitAreaFrom,
    required this.unitAreaTo,
    required this.unitPercentage,
    required this.unitNumberOfYears,
    required this.unitFinishingType,
  }) : super(
          //==> unitTypeName
          name: unitTypeName.name.isNotEmpty
              ? unitTypeName.name
              : unitTypeName.arabicName.isNotEmpty
                  ? unitTypeName.arabicName
                  : AppUtils.undefined,

          //==> layout
          layout: unitLayout.name.isNotEmpty
              ? unitLayout.name
              : unitLayout.arabicName.isNotEmpty
                  ? unitLayout.arabicName
                  : AppUtils.undefined,

          priceFrom: unitPriceFrom,
          priceTo: unitPriceTo,
          areaFrom: unitAreaFrom,
          areaTo: unitAreaTo,
          percentage: unitPercentage,
          numberOfYears: unitNumberOfYears,

          isCommercial: unitTypeName.isCommercial,

          finishingType: unitFinishingType.name.isNotEmpty
              ? unitFinishingType.name
              : unitFinishingType.arabicName.isNotEmpty
                  ? unitFinishingType.arabicName
                  : AppUtils.undefined,
        );

  final UnitTypeName unitTypeName;
  final UnitTypeLayout unitLayout;
  final String unitPriceFrom;
  final String unitPriceTo;
  final String unitAreaFrom;
  final String unitAreaTo;
  final int unitPercentage;
  final int unitNumberOfYears;
  final UnitFinishingType unitFinishingType;

  factory UnitTypeSet.fromJson(Map<String, dynamic> json) => UnitTypeSet(
        // unitTypeName
        unitTypeName: json["unitTypeName"] != null
            ? UnitTypeName.fromJson(json["unitTypeName"])
            : UnitTypeName.empty(),
        // unitLayout
        unitLayout: json["layout"] != null
            ? UnitTypeLayout.fromJson(json["layout"])
            : UnitTypeLayout.empty(),
        // unitFinishingType
        unitFinishingType: json["finishingType"] != null
            ? UnitFinishingType.fromJson(json["finishingType"])
            : UnitFinishingType.empty(),
        // unitPriceFrom
        unitPriceFrom: json["priceFrom"] ?? AppUtils.undefined,
        // unitPriceTo
        unitPriceTo: json["priceTo"] ?? AppUtils.undefined,
        // unitAreaFrom
        unitAreaFrom: json["areaFrom"] ?? AppUtils.undefined,
        // unitAreaTo
        unitAreaTo: json["areaTo"] ?? AppUtils.undefined,
        // unitPercentage
        unitPercentage: json["percentage"] ?? -1,
        // numberOfYears
        unitNumberOfYears: json["numberOfYears"] ?? -1,
      );
}

/// UnitTypeLayout
class UnitTypeName {
  const UnitTypeName({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.isCommercial,
    required this.priority,
  });

  final String id;
  final String name;
  final String arabicName;
  final bool isCommercial;
  final int priority;

  factory UnitTypeName.fromJson(Map<String, dynamic> json) => UnitTypeName(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        arabicName: json["arabicName"] ?? AppUtils.undefined,
        isCommercial: json["isCommercial"] ?? false,
        priority: json["priority"] ?? -1,
      );

  factory UnitTypeName.empty() => const UnitTypeName(
        id: AppUtils.undefined,
        name: "",
        arabicName: "",
        isCommercial: false,
        priority: -1,
      );
}

/// UnitTypeLayout
class UnitTypeLayout {
  const UnitTypeLayout({
    required this.id,
    required this.name,
    required this.arabicName,
  });

  final String id;
  final String name;
  final String arabicName;

  factory UnitTypeLayout.fromJson(Map<String, dynamic> json) => UnitTypeLayout(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        arabicName: json["arabicName"] ?? AppUtils.undefined,
      );

  factory UnitTypeLayout.empty() => const UnitTypeLayout(
        id: AppUtils.undefined,
        name: "",
        arabicName: "",
      );
}

/// UnitFinishingType
class UnitFinishingType {
  const UnitFinishingType({
    required this.id,
    required this.name,
    required this.arabicName,
  });

  final String id;
  final String name;
  final String arabicName;

  factory UnitFinishingType.fromJson(Map<String, dynamic> json) =>
      UnitFinishingType(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        arabicName: json["arabicName"] ?? AppUtils.undefined,
      );

  factory UnitFinishingType.empty() => const UnitFinishingType(
        id: AppUtils.undefined,
        name: "",
        arabicName: "",
      );
}

enum ProjectType { commercial, residential, unDefined }

final typeValues = EnumValues({
  "COMMERCIAL": ProjectType.commercial,
  "RESIDENTIAL": ProjectType.residential,
  "UNDEFINED": ProjectType.unDefined
});

class EnumValues<T> {
  Map<String, T> map;

  EnumValues(this.map);
}
