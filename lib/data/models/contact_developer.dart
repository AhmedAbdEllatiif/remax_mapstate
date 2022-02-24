import 'package:remax_mapstate/domain/entities/contact_developer.dart';

class ContactDeveloperModel extends ContactDeveloperEntity {
  final int id;
  final String developerName;
  final String? developerLocation;
  final String empFirstName;
  final String? empSecondName;
  final String empPhoneNum;
  final String? image;

  const ContactDeveloperModel({
    required this.id,
    required this.developerName,
    this.developerLocation,
    required this.empFirstName,
    this.empSecondName,
    required this.empPhoneNum,
    this.image,
  }) : super(
          id: id,
          developerName: developerName,
          developerLocation: developerLocation,
          empFirstName: empFirstName,
          empSecondName: empSecondName,
          empPhoneNum: empPhoneNum,
          image: image,

        );
}
