import 'package:flutter/material.dart';

import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/journeys/projects/projects_argument.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

class AreaCardWidget extends StatelessWidget {
  final AreaEntity area;

  const AreaCardWidget({Key? key, required this.area}) : super(key: key);

  /// to navigate to ProjectsScreen
  void _navigateToAreaScreen(BuildContext context) => RouteHelper()
      .areaScreen(context, areaArgument: AreaArgument(area: area));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToAreaScreen(context),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Center(
          child: Text(
            area.title,
            maxLines: 2,
            style: Theme.of(context).textTheme.vulcanBodyText2.copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
