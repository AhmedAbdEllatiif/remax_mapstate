import 'package:flutter/material.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_argument.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectDetailsArgument projectDetailsArgument;

  const ProjectDetailsScreen({Key? key, required this.projectDetailsArgument})
      : super(key: key);

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Project Details"),
      ),
        body: const Center(
      child: Text("Project Screen Details"),
    ));
  }
}
