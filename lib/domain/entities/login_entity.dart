import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/authorized_user_entity.dart';

class LoginEntity extends Equatable {
  final String userToken;
  final AuthorizedUserEntity authorizedUserEntity;

  const LoginEntity({
    required this.userToken,
    required this.authorizedUserEntity,
  });

  @override
  List<Object?> get props => [userToken, authorizedUserEntity];
}
