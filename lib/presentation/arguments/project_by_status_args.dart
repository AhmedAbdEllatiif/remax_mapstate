import 'package:remax_mapstate/domain/entities/project_status_entity.dart';

class ProjectByStatusArguments {
  final ProjectStatusEntity projectStatusEntity;
  final String areaId;
  final String areaName;

  ProjectByStatusArguments(
      {this.areaId = "",this.areaName = "", required this.projectStatusEntity});
}
