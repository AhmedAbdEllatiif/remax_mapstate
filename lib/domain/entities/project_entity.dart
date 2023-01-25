import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_display/number_display.dart';
import 'package:remax_mapstate/common/constants/api_constants.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/functions/services_mapper.dart';
import 'package:remax_mapstate/data/models/project_model.dart';
import 'package:remax_mapstate/domain/entities/service_entity.dart';

import '../../common/constants/app_utils.dart';

class ProjectEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String priceFrom;
  final String areaFrom;
  final String deliveryYear;
  final String deliveryMonth;
  final ProjectType type;
  final String status;
  final String region;
  final String zone;
  final List<String> services;
  final List<UnitTypeSetEntity> unitTypeSets;
  late List<String> images;
  final int planPercentage;
  final int planNumberOfYears;
  final LocationEntity location;
  final DeveloperEntity developer;
  late final String formattedStartingPrice;
  late final List<ServiceEntity> servicesEntities;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.priceFrom,
    required this.areaFrom,
    required this.deliveryYear,
    required this.deliveryMonth,
    required this.type,
    required this.status,
    required this.region,
    required this.zone,
    required this.services,
    required this.unitTypeSets,
    required this.planPercentage,
    required this.planNumberOfYears,
    required this.location,
    required this.developer,
    required List<String> imageList,
  }) {
    // init images
    images = [];
    for (var element in imageList) {
      images.add(ApiConstants.baseMediaWithoutUrl + element);
    }

    final display = createDisplay(
      length: 15,
      decimal: 0,
    );

    final doublePriceFrom = double.tryParse(priceFrom);

    formattedStartingPrice =
        doublePriceFrom == null ? priceFrom : display(doublePriceFrom);

    //==> init services entities
    servicesEntities = [];
    for (var element in services) {
      if (servicesMapper().containsKey(element)) {
        final servicePath = servicesMapper()[element];
        servicesEntities.add(ServiceEntity(
          name: element,
          path: servicePath ?? AssetsConstants.gym,
        ));
      } else {
        servicesEntities.add(ServiceEntity(
          name: element,
          path: AssetsConstants.gym,
        ));
      }
    }
  }

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
  }) {
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
  UnitTypeSetEntity({
    required this.name,
    required this.layout,
    required this.priceFrom,
    required this.priceTo,
    required this.areaFrom,
    required this.areaTo,
    required this.percentage,
    required this.numberOfYears,
    required this.finishingType,
    required this.isCommercial,
  }) {
    final display = createDisplay(
      length: 15,
      decimal: 0,
    );
    final doublePriceFrom = double.tryParse(priceFrom);
    final doublePriceTo = double.tryParse(priceTo);

    // init formattedPriceFrom
    formattedPriceFrom =
        doublePriceFrom == null ? priceFrom : display(doublePriceFrom);

    // init formattedPriceTo
    formattedPriceTo = doublePriceTo == null ? priceTo : display(doublePriceTo);

    // init unitTypeTitle (used for ui)
    if (layout == AppUtils.undefined) {
      unitTypeTitle = name;
    } else {
      unitTypeTitle = name + " - " + "( $layout )";
    }
  }

  final String name;
  final String layout;
  final String priceFrom;
  final String priceTo;
  final String areaFrom;
  final String areaTo;
  final int percentage;
  final int numberOfYears;
  final String finishingType;
  final bool isCommercial;
  late final String formattedPriceFrom;
  late final String formattedPriceTo;
  late final String unitTypeTitle;

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
  DeveloperContactEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.profileImagePath,
  }) {
    profileImage =
        profileImagePath == AppUtils.undefined || profileImagePath == ""
            ? AppUtils.undefined
            : ApiConstants.baseMediaUrl + profileImagePath.trim();

    final String buildFirstName =
        firstName != AppUtils.undefined ? firstName : "";
    final String buildLastName = lastName != AppUtils.undefined ? lastName : "";

    fullName = buildFirstName + " " + buildLastName;
  }

  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String profileImagePath;
  late final String profileImage;
  late final String fullName;

  @override
  List<Object?> get props => [id];
}

class LocationEntity extends Equatable {
  const LocationEntity({
    required this.id,
    required this.locationText,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String locationText;
  final String address;
  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [id];
}

class EnumValues<T> {
  Map<String, T> map;

  EnumValues(this.map);
}
