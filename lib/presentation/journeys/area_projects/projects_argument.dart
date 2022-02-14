import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';

class ProjectsArgument extends Equatable{
  final AreaEntity area;

  const ProjectsArgument({
    required this.area,
  });

  @override
  List<Object?> get props => [area];
}