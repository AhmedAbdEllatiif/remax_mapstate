import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';

class AreaArgument extends Equatable{
  final AreaEntity area;

  const AreaArgument({
    required this.area,
  });

  @override
  List<Object?> get props => [area];
}