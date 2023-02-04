import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/common/constants/api_constants.dart';

class ServiceTypeEntity extends Equatable {
  final String id;
  final String name;

  late final String icon;

  ServiceTypeEntity({
    required this.id,
    required this.name,
    required final String serviceIcon,
  }) {
    icon = ApiConstants.baseMediaWithoutUrl + serviceIcon;
  }

  @override
  List<Object?> get props => [id, icon];
}
