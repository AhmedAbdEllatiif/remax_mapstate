import 'package:remax_mapstate/domain/entities/project_entity.dart';

class ProjectDetailsArgument{
  final String projectId;
  final ProjectEntity projectEntity;

  const ProjectDetailsArgument({
    required this.projectId,
    required this.projectEntity,
  });
}