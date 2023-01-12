import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/user_entity.dart';

class ProfileEntity extends Equatable {
  final UserEntity userEntity;

  const ProfileEntity({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}
