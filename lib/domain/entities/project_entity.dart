import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/data/models/project_model.dart';

class ProjectEntity extends Equatable {
  const ProjectEntity({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.descriptionArabic,
    required this.priceFrom,
    required this.areaFrom,
    required this.deliveryYear,
    required this.type,
    required this.status,
    required this.region,
    required this.zone,
    required this.services,
    required this.unitTypeSet,
    required this.paymentPlan,
    required this.location,
    required this.developer,
  });

  final String id;
  final String name;
  final String arabicName;
  final String description;
  final String descriptionArabic;
  final String priceFrom;
  final String areaFrom;
  final String deliveryYear;
  final ProjectType type;
  final DifferentLanguagesEntity status;
  final DifferentLanguagesEntity region;
  final DifferentLanguagesEntity zone;
  final List<DifferentLanguagesEntity> services;
  final List<UnitTypeSetEntity> unitTypeSet;
  final PaymentPlanEntity paymentPlan;
  final dynamic location;
  final DeveloperEntity developer;

  @override
  List<Object> get props => [id];

  @override
  String toString() {
    return "\nProjectId: $id , Name: $name, Type: $type\n";
  }
}

class DeveloperEntity extends Equatable {
  const DeveloperEntity({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}

class PaymentPlanEntity extends Equatable {
  const PaymentPlanEntity({
    required this.percentage,
    required this.numberOfYears,
  });

  final int percentage;
  final int numberOfYears;

  @override
  List<Object> get props => [percentage, numberOfYears];
}

class DifferentLanguagesEntity extends Equatable {
  const DifferentLanguagesEntity({
    required this.name,
    required this.arabicName,
  });

  final String name;
  final String arabicName;

  @override
  List<Object?> get props => [name, arabicName];
}

class UnitTypeSetEntity extends Equatable {
  const UnitTypeSetEntity({
    required this.unitTypeName,
    required this.layout,
    required this.priceFrom,
    required this.areaFrom,
    required this.percentage,
    required this.finishingType,
  });

  final DifferentLanguagesEntity unitTypeName;
  final DifferentLanguagesEntity layout;
  final String priceFrom;
  final String areaFrom;
  final int percentage;
  final DifferentLanguagesEntity finishingType;

  @override
  List<Object?> get props => [
    unitTypeName,
    layout,
    priceFrom,
    areaFrom,
    percentage,
    finishingType,
  ];
}

class EnumValues<T> {
  Map<String, T> map;

  EnumValues(this.map);
}
