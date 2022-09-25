import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';

class AreaUnitTypesArguments extends Equatable{
  final AreaEntity area;

  const AreaUnitTypesArguments({
    required this.area,
  });

  @override
  List<Object?> get props => [area];
}