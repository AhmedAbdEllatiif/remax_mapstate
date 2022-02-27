import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/data/models/contact_developer.dart';
import 'package:remax_mapstate/domain/entities/map_entity.dart';

class ContactDeveloperEntity extends Equatable {
  final int id;
  final String developerName;
  final MapEntity? mapEntity;
  final String empFirstName;
  final String? empSecondName;
  final String empPhoneNum;
  final String? image;

  const ContactDeveloperEntity({
    required this.id,
    required this.developerName,
    this.mapEntity,
    required this.empFirstName,
    this.empSecondName,
    required this.empPhoneNum,
    this.image,
  });

  factory ContactDeveloperEntity.fromContactDeveloperModel(
      ContactDeveloperModel developerModel) {
    return ContactDeveloperEntity(
      id: developerModel.id,
      empFirstName: developerModel.empFirstName,
      empSecondName: developerModel.empSecondName,
      empPhoneNum: developerModel.empPhoneNum,
      developerName: developerModel.developerName,
      image: developerModel.image,
      mapEntity:
          developerModel.latitude != null && developerModel.longitude != null
              ? MapEntity(
                  latitude: developerModel.latitude!,
                  longitude: developerModel.longitude!,
                  markerTitle: developerModel.developerName,
                )
              : null,
    );
  }

  @override
  List<Object?> get props => [id];
}
