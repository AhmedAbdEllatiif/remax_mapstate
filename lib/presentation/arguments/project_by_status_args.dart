import 'package:remax_mapstate/domain/entities/project_status_entity.dart';

class ProjectByStatusArguments {
  final ProjectStatusEntity projectStatusEntity;
  final String areaId;

  ProjectByStatusArguments({ this.areaId = "",required this.projectStatusEntity});
}
