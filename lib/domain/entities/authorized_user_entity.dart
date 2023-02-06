import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/data/models/user_model.dart';
import 'package:remax_mapstate/domain/entities/users/user_entity.dart';
import '../../../common/constants/app_utils.dart';
import '../../common/enums/user_types.dart';

class AuthorizedUserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNum;
  UserType userType;

  AuthorizedUserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNum,
    required this.userType,
  });

  factory AuthorizedUserEntity.fromUserModel(UserModel userModel) =>
      AuthorizedUserEntity(
        id: userModel.id.toString(),
        firstName: userModel.firstName,
        lastName: userModel.lastName,
        email: userModel.email,
        phoneNum: userModel.phoneNumber,
        userType: userModel.userType,
      );

  factory AuthorizedUserEntity.fromUserEntity(UserEntity userEntity) =>
      AuthorizedUserEntity(
        id: userEntity.id.toString(),
        firstName: userEntity.firstName,
        lastName: userEntity.lastName,
        email: userEntity.email,
        phoneNum: userEntity.phoneNumber,
        userType: userEntity.userType,
      );

  factory AuthorizedUserEntity.empty() => AuthorizedUserEntity(
        id: "-1",
        firstName: AppUtils.undefined,
        lastName: AppUtils.undefined,
        email: AppUtils.undefined,
        phoneNum: "01*********",
        userType: UserType.unDefined,
      );

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNum,
        userType,
      ];
}
