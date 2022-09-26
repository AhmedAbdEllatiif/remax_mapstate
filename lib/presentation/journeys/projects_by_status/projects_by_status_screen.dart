import 'package:flutter/material.dart';
import 'package:remax_mapstate/presentation/arguments/project_by_status_args.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';

class ProjectsByStatusScreen extends StatefulWidget {
  final ProjectByStatusArguments projectByStatusArguments;

  const ProjectsByStatusScreen(
      {Key? key, required this.projectByStatusArguments})
      : super(key: key);

  @override
  _ProjectsByStatusScreenState createState() => _ProjectsByStatusScreenState();
}

class _ProjectsByStatusScreenState extends State<ProjectsByStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return StackScaffoldWithFullBackground(
        body: Center(
      child: Text(
          "Status: ${widget.projectByStatusArguments.projectStatusEntity.name}"),
    ));
  }
}
