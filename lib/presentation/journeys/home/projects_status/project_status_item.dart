import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/constants/argument_constants.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/presentation/arguments/project_by_status_args.dart';
import 'package:remax_mapstate/presentation/arguments/project_details_argument.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../../../../router/route_hepler.dart';

class ProjectStatusItem extends StatelessWidget {
  final ProjectStatusEntity statusEntity;

  const ProjectStatusItem({Key? key, required this.statusEntity})
      : super(key: key);

  /// to navigate to ProjectDetailsScreen
  void _navigateToProjectByStatusScreen(BuildContext context) {
    if (statusEntity.name == "Oppurtunities" || statusEntity.name == "Offers") {
      RouteHelper().projectsByStatus(
        context,
        projectByStatusArguments: ProjectByStatusArguments(
          projectStatusEntity: statusEntity,
        ),
      );
    } else {
      RouteHelper().areasByStatusScreen(
        context,
        projectByStatusArguments: ProjectByStatusArguments(
          projectStatusEntity: statusEntity,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColor.geeBung)),
          padding: EdgeInsets.all(20),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Ready to \nMove",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.bold, height: 1.1),
              ),
            ),
            Material(
              elevation: 32.0,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => _navigateToProjectByStatusScreen(context),
                child: Image.asset(
                  statusEntity.image,
                  //height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/*Card(
                      shadowColor: AppColor.black,
                      color: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28)),
                      ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                           AppColor.geeBung,
                            Colors.black,
                            Colors.black,
                            Colors.black,
                            Colors.black,
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(28),

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Center(
                            child: Text('Enter further widgets here'),
                          ),
                        ),
                      ),
                    ),
                    );*/
