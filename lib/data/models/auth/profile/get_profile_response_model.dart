import 'package:remax_mapstate/domain/entities/profile_entity.dart';

import '../../user_model.dart';

/// to return [GetProfileResponseModel] from received data
GetProfileResponseModel getProfileResponseFromJson(dynamic data) => data == null
    ? GetProfileResponseModel.fromJson(const {})
    : GetProfileResponseModel.fromJson(data);

/// model class for received profile data
class GetProfileResponseModel extends ProfileEntity {
  final UserModel userModel;

  const GetProfileResponseModel({
    required this.userModel,
  }) : super(userEntity: userModel);

  factory GetProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return GetProfileResponseModel(
      userModel: userModelFormMe(json),
    );
  }
}
