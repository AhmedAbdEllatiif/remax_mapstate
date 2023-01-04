import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/enums/user_types.dart';

class UserEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final UserType userType;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userType,
  });

  factory UserEntity.empty() => const UserEntity(
        id: -1,
        firstName: AppUtils.undefined,
        lastName: AppUtils.undefined,
        email: AppUtils.undefined,
        userType: UserType.unDefined,
      );

  @override
  List<Object?> get props => [id];
}
