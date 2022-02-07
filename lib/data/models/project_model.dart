import 'package:remax_mapstate/domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  final int id;
  final String imageUrl;
  final String name;
  final String description;

  const ProjectModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
        );
}
