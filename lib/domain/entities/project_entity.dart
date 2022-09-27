import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_display/number_display.dart';
import 'package:remax_mapstate/common/constants/api_constants.dart';
import 'package:remax_mapstate/data/models/project_model.dart';

class ProjectEntity extends Equatable {
  ProjectEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.finishingType,
    required this.priceFrom,
    required this.areaFrom,
    required this.deliveryYear,
    required this.deliveryMonth,
    required this.type,
    required this.status,
    required this.region,
    required this.zone,
    required this.services,
    required this.unitTypeSet,
    required this.planPercentage,
    required this.planNumberOfYears,
    required this.location,
    required this.developer,
  }) {
    final display = createDisplay(
      length: 12,
      decimal: 0,
    );

    final doublePriceFrom = double.tryParse(priceFrom);

    formattedPrice =
        doublePriceFrom == null ? priceFrom : display(doublePriceFrom);
  }

  final String id;
  final String name;
  final String description;
  final String finishingType;
  final String priceFrom;
  final String areaFrom;
  final String deliveryYear;
  final String deliveryMonth;
  final ProjectType type;
  final String status;
  final String region;
  final String zone;
  final List<String> services;
  final List<UnitTypeSetEntity> unitTypeSet;
  final int planPercentage;
  final int planNumberOfYears;
  final LocationEntity location;
  final DeveloperEntity developer;
  late final String formattedPrice;

  @override
  List<Object> get props => [id];

  @override
  String toString() {
    return "\nProjectId: $id , Name: $name, Type: $type\n";
  }
}

class DeveloperEntity extends Equatable {
   DeveloperEntity({
    required this.id,
    required this.name,
    required this.logo,
    required this.developerContactEntity,
    required this.locationEntity,
  }){
     logoFullPath = ApiConstants.baseMediaUrl + logo;
   }

  final String id;
  final String name;
  final String logo;
  late final String logoFullPath;
  final DeveloperContactEntity developerContactEntity;
  final LocationEntity locationEntity;

  @override
  List<Object> get props => [id];
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
    required this.name,
    required this.layout,
    required this.priceFrom,
    required this.areaFrom,
    required this.percentage,
    required this.finishingType,
  });

  final String name;
  final String layout;
  final String priceFrom;
  final String areaFrom;
  final int percentage;
  final String finishingType;

  @override
  List<Object?> get props => [
        name,
        layout,
        priceFrom,
        areaFrom,
        percentage,
        finishingType,
      ];
}

class DeveloperContactEntity extends Equatable {
  const DeveloperContactEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.image,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String image;

  @override
  List<Object?> get props => [id];
}

class LocationEntity extends Equatable {
  const LocationEntity({
    required this.id,
    required this.locationText,
    required this.address,
    required this.geometry,
  });

  final String id;
  final String locationText;
  final String address;
  final dynamic geometry;

  @override
  List<Object?> get props => [id];
}

class EnumValues<T> {
  Map<String, T> map;

  EnumValues(this.map);
}
