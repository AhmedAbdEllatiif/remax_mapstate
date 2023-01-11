import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/domain/entities/register_entity.dart';

/// to return a [RegisterResponseModel] from received data
RegisterResponseModel registerResponseModelFromJson(dynamic data) {
  return RegisterResponseModel.fromJson(
    data["register"] ?? {},
  );
}

class RegisterResponseModel extends RegisterEntity {
  final bool success;
  final String token;
  final dynamic errors;

  const RegisterResponseModel({
    required this.success,
    required this.token,
    required this.errors,
  }) : super(
          userToken: token,
        );

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json["success"] ?? false,
      token: json["token"] ?? AppUtils.undefined,
      errors: json["errors"] ?? [],
    );
  }
}
