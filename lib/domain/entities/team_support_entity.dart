import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/constants/api_constants.dart';

class TeamSupportEntity extends Equatable {
  final String id;
  final String name;
  final String phoneNum;
  final String whatsappNum;

  late final String avatar;

  TeamSupportEntity({
    required this.id,
    required this.name,
    required this.phoneNum,
    required this.whatsappNum,
    required final String image,
  }) {
    avatar = ApiConstants.baseMediaWithoutUrl + image;
  }

  @override
  List<Object?> get props => [id];
}
