import 'package:remax_mapstate/data/params/update_ambassador_data_params.dart';

class UpdateAmbassadorRequestModel {
  final int ambassadorId;
  final String? currentJobTitle;

  UpdateAmbassadorRequestModel({
    required this.ambassadorId,
    this.currentJobTitle,
  });

  //
  factory UpdateAmbassadorRequestModel.fromParams(
      {required UpdateAmbassadorDataParams params}) {
    return UpdateAmbassadorRequestModel(
      ambassadorId: params.ambassadorId,
      currentJobTitle: params.currentJobTitle,
    );
  }

  Map<String, dynamic> toJson() {
    if (currentJobTitle != null) {
      return {
        "user": ambassadorId,
        "currentJobTitle": currentJobTitle,
      };
    }

    return {
      "user": ambassadorId,
    };
  }
}
