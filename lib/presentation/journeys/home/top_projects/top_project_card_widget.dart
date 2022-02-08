import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/argument_constants.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_argument.dart';
import 'package:remax_mapstate/router/app_router.dart';

class TopProjectCardWidget extends StatelessWidget {

  final int projectId;
  final String posterPath;
  const TopProjectCardWidget({Key? key, required this.projectId, required this.posterPath}) : super(key: key);

  /// to navigate to ProjectDetailsScreen
  void _navigateToProjectsScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(AppRouter.projectDetailsScreen, arguments: {
        ArgumentConstants.projectDetails: ProjectDetailsArgument(projectId: projectId,),
      });



  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32.0,
      color: Colors.transparent,
      child: GestureDetector(
        onTap: ()=>_navigateToProjectsScreen(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
          child:
          Image.asset(
            posterPath,
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
