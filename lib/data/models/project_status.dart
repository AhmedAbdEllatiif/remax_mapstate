import 'package:remax_mapstate/domain/entities/project_status_entity.dart';

class ProjectStatusModel extends ProjectStatusEntity{

  final int id;
  final String name;
  final String image;

  const ProjectStatusModel({
    required this.id,
    required this.name,
    required this.image,
  }) : super(id: id, name: name,image: image);
}