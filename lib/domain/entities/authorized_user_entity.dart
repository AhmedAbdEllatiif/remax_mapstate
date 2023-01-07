import 'package:equatable/equatable.dart';
import '../../../common/constants/app_utils.dart';
import '../../common/enums/user_types.dart';

class AuthorizedUserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNum;
  final UserType userType;

  const AuthorizedUserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNum,
    required this.userType,
  });

  factory AuthorizedUserEntity.empty() => const AuthorizedUserEntity(
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
