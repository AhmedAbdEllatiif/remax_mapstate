import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/argument_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/journeys/area_projects/projects_argument.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/router/app_router.dart';

class AreaCardWidget extends StatelessWidget {

  final AreaEntity area;

  const AreaCardWidget({Key? key, required this.area}) : super(key: key);


  /// to navigate to ProjectsScreen
  void _navigateToProjectsScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(AppRouter.projectsScreen, arguments: {
        ArgumentConstants.projectsArgument: ProjectsArgument(area: area),
      });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProjectsScreen(context),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Center(
          child: Text(area.title,
            maxLines: 2,
            style: Theme.of(context).textTheme.royalBlueBodyText2,
          ),
        ),
      ),
    );
  }
}
