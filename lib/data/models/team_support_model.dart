import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/domain/entities/team_support_entity.dart';

List<TeamSupportModel> listOFTeamSupportModelFromJson(dynamic json) {
  final List<TeamSupportModel> users = [];
  if (json == null) {
    throw Exception(
        "TeamSupportModel >> teamSupportModelFromJson >> json is null");
  }

  if (json["teamSupportUsers"] == null) {
    throw Exception(
        "TeamSupportModel >> teamSupportModelFromJson >> teamSupportUsers is null");
  }

  for (var element in json["teamSupportUsers"]) {
    users.add(TeamSupportModel.fromJson(element));
  }

  return users;
}

class TeamSupportModel extends TeamSupportEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNum;
  final String whatsappNum;
  final String image;

  TeamSupportModel({
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

  factory TeamSupportModel.fromJson(dynamic json) {
    return TeamSupportModel(
      id: json["id"] ?? -1,

      // firstName
      firstName: json["firstName"] ?? AppUtils.undefined,

      // lastName
      lastName: json["lastName"] ?? "",

      // phoneNum
      phoneNum: json["phone"] ?? AppUtils.undefined,

      // whatsappNum
      whatsappNum: json["mapEstateUser"] != null
          ? json["mapEstateUser"]["whatsapp"] ?? AppUtils.undefined
          : AppUtils.undefined,

      // image
      image: json["mapEstateUser"] != null
          ? json["mapEstateUser"]["avatar"] ?? AppUtils.undefined
          : AppUtils.undefined,
    );
  }
}
