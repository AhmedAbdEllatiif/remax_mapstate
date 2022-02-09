import 'package:equatable/equatable.dart';

class ProjectParamEntity extends Equatable {
  final int projectId;

  const ProjectParamEntity({
    required this.projectId,
  });

  @override
  List<Object> get props => [projectId];
}