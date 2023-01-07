import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/data/models/user_model.dart';

LoginResponseModel loginResponseModelFromJson(final Map<String, dynamic> json) {
  return LoginResponseModel.formJson(json);
}

class LoginResponseModel {
  final bool success;
  final String token;
  final Map<String, dynamic> errors;
  final UserModel userModel;

  LoginResponseModel({
    required this.success,
    required this.token,
    required this.errors,
    required this.userModel,
  });

  factory LoginResponseModel.formJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        success: json["success"] ?? false,
        token: json["token"] ?? AppUtils.undefined,
        errors: json["errors"] ?? {},
        userModel: json["user"] != null
            ? UserModel.formJson(json["user"])
            : UserModel.empty(),
      );
}
