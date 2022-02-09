import 'package:flutter/material.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/presentation/journeys/home/top_projects/project_backdrop_widget.dart';
import 'package:remax_mapstate/presentation/journeys/home/top_projects/project_page_view.dart';
import 'package:remax_mapstate/presentation/journeys/home/top_projects/top_project_data.dart';
import 'package:remax_mapstate/presentation/widgets/separator.dart';

class TopProjectWidget extends StatelessWidget {
  final List<ProjectEntity> projects;
  final int defaultIndex;


  const TopProjectWidget({Key? key, required this.projects, required this.defaultIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [

        // backdrop image of project
        const ProjectBackDropWidget(),

        // scroll view with projects
        Column(
          children: [

            // scroll view with top projects
            ProjectPageView(
              projects: projects,
              initialPage: defaultIndex,
            ),


            // project data
            const TopProjectDataWidget(),

            // separator
            const Separator(),
          ],
        ),




      ],
    );
  }
}
