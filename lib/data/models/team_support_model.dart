import 'package:remax_mapstate/domain/entities/team_support_entity.dart';

class TeamSupportModel extends TeamSupportEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNum;
  final String whatsappNum;
  final String image;

  const TeamSupportModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNum,
    required this.whatsappNum,
    required this.image,
  }) : super(
          id: id,
          name: "$firstName $lastName",
          phoneNum: phoneNum,
          whatsappNum: whatsappNum,
          image: image,
        );
}
