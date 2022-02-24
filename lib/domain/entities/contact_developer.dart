import 'package:equatable/equatable.dart';

class ContactDeveloperEntity extends Equatable{
  final int id;
  final String developerName;
  final String? developerLocation;
  final String empFirstName;
  final String? empSecondName;
  final String empPhoneNum;
  final String? image;


  const ContactDeveloperEntity({
    required this.id,
    required this.developerName,
    this.developerLocation,
    required this.empFirstName,
    this.empSecondName,
    required this.empPhoneNum,
    this.image,
  });

  @override
  List<Object?> get props =>[id];

}