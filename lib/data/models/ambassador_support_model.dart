import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/domain/entities/ambassador_support_entity.dart';

List<AmbassadorSupportModel> listOfAmbassadorSupportModelFromJson(
    dynamic json) {
  final List<AmbassadorSupportModel> users = [];
  if (json == null) {
    throw Exception(
        "AmbassadorSupportModel >> listOfAmbassadorSupportModelFromJson >> json is null");
  }

  if (json["ambassadorSupportUsers"] == null) {
    throw Exception(
        "AmbassadorSupportModel >> listOfAmbassadorSupportModelFromJson >>"
            " ambassadorSupportUsers is null");
  }

  for (var element in json["ambassadorSupportUsers"]) {
    users.add(AmbassadorSupportModel.fromJson(element));
  }

  return users;
}

class AmbassadorSupportModel extends AmbassadorSupportEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNum;
  final String whatsappNum;
  final String image;

  AmbassadorSupportModel({
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

  factory AmbassadorSupportModel.fromJson(dynamic json) {
    return AmbassadorSupportModel(
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
