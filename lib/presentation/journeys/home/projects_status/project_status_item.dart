import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/argument_constants.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/presentation/arguments/project_by_status_args.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_argument.dart';


import '../../../../router/route_hepler.dart';

class ProjectStatusItem extends StatelessWidget {
  final ProjectStatusEntity statusEntity;

  const ProjectStatusItem(
      {Key? key, required this.statusEntity})
      : super(key: key);

  /// to navigate to ProjectDetailsScreen
  void _navigateToProjectByStatusScreen(BuildContext context) =>
      RouteHelper().projectByStatus(
        context,
        projectByStatusArguments : ProjectByStatusArguments(
          projectStatusEntity: statusEntity,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32.0,
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => _navigateToProjectByStatusScreen(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
          child: Image.asset(
            statusEntity.image,
            fit: BoxFit.cover,
          ),
          /*CachedNetworkImage(
            imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterPath',
            fit: BoxFit.cover,
          ),*/
          /*child: Image.network(
              '${ApiConstants.BASE_IMAGE_URL}$posterPath',
          ),*/
        ),
      ),
    );
  }
}
