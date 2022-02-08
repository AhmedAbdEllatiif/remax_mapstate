import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/bloc/top_projects/top_projects_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/top_projects/top_projects_bloc.dart';
import 'package:remax_mapstate/presentation/journeys/projects/project_card.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_argument.dart';

class ProjectsScreen extends StatefulWidget {

  final ProjectsArgument projectsArgument;

  const ProjectsScreen({Key? key, required this.projectsArgument}) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// Appbar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.projectsArgument.area.title
          //TranslateConstants.projects.t(context),
        ),
      ),

      /// body
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 15,
            itemBuilder: (context, index) => const ProjectCardWidget()
        ),
      ),
    );
  }
}
