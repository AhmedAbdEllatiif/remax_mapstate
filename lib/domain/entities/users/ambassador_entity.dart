import 'package:equatable/equatable.dart';

import '../../../common/constants/api_constants.dart';
import '../../../common/constants/app_utils.dart';
import '../../../data/models/user_model.dart';

class AmbassadorEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String userProfileImage;
  final String jobTitle;
  final int doneDeals;
  late final String avatar;

  AmbassadorEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.jobTitle,
    required this.userProfileImage,
    required this.doneDeals,
  }) {
    if(userProfileImage.startsWith("http")){
      avatar =  userProfileImage;
    }
    else if (userProfileImage != AppUtils.undefined) {
      avatar = ApiConstants.baseMediaWithoutUrl + userProfileImage;
    } else {
      avatar = AppUtils.undefined;
    }
  }

  /*
  *
  *
  * from UserModel
  *
  *
  * */
  factory AmbassadorEntity.fromUserModel(UserModel userModel) =>
      AmbassadorEntity(
        id: userModel.userId,
        firstName: userModel.firstName,
        lastName: userModel.lastName,
        email: userModel.email,
        phoneNumber: userModel.phoneNumber,
        userProfileImage: userModel.avatar,
        jobTitle: userModel.ambassadorJobTitle,
        doneDeals: userModel.ambassadorDoneDealsCount,
      );

  /*
  *
  *
  * empty
  *
  *
  * */
  factory AmbassadorEntity.empty() => AmbassadorEntity(
        id: "-1",
        firstName: AppUtils.undefined,
        lastName: AppUtils.undefined,
        email: AppUtils.undefined,
        phoneNumber: AppUtils.undefined,
        userProfileImage: AppUtils.undefined,
        jobTitle: AppUtils.undefined,
        doneDeals: -1,
      );

  /// override props
  @override
  List<Object?> get props => [id, firstName, lastName];

  @override
  String toString() {
    return "firstName: $firstName\n"
        "lastName: $lastName\n"
        "email: $email\n"
        "phone: $phoneNumber\n"
        "currentJob: $jobTitle\n";
  }
}
