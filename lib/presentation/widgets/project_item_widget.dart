import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/presentation/arguments/project_details_argument.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/cached_image_widget.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../router/route_hepler.dart';

class ProjectItemWidget extends StatelessWidget {
  final ProjectEntity projectEntity;

  const ProjectItemWidget({Key? key, required this.projectEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Sizes.dimen_100.h,
      height: ResponsiveValue<double>(context,
          defaultValue: Sizes.dimen_100.h,
          valueWhen: [
            Condition.equals(name: TABLET, value: Sizes.dimen_230.h),
            Condition.largerThan(name: TABLET, value: Sizes.dimen_230.h),
            Condition.equals(name: MOBILE, value: Sizes.dimen_100.h),
            Condition.smallerThan(name: MOBILE, value: Sizes.dimen_80.h),
          ]).value,
      width: ScreenUtil.screenWidth,
      child: Container(
        //color: colors[index],

        child: GestureDetector(
          onTap: () => _navigateToProjectsScreen(context),
          child: GridTile(
              child: /*Image.network(projectEntity.images[0],),*/CachedImageWidget(
                height: double.infinity,
                imageUrl: projectEntity.images[0],
                width: double.infinity,
                progressBarScale: 0.2,
                isCircle: false,
                boxFit: BoxFit.cover,
              ),


              // grid tile footer
              footer: Container(
                color: AppColor.black.withOpacity(0.7),
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Row (Avatar and District data)
                    Expanded(
                      child: Row(
                        children: [
                          /// Avatar Image

                          CachedImageWidget(
                            imageUrl: projectEntity.developer.logoFullPath,
                            height: 50,
                            width: 50,
                            progressBarScale: 0.7,
                            isCircle: true,
                          ),


                          // SizedBox
                          const SizedBox(
                            width: 5,
                          ),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  projectEntity.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: AppColor.white),
                                ),
                                Text(
                                  projectEntity.zone,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                    color: AppColor.geeBung,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    /// Column of Starting price
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          TranslateConstants.startingPrice
                              .t(context)
                              .intelliTrim_14(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                            color: AppColor.white,
                          ),
                        ),
                        Text(
                          projectEntity.formattedStartingPrice,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                              color: AppColor.geeBung,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ),
        // stack

      ),
    );
  }

  /// to navigate to ProjectDetailsScreen
  /// to navigate to ProjectDetailsScreen
  void _navigateToProjectsScreen(BuildContext context) =>
      RouteHelper().projectDetailScreen(
        context,
        projectDetailsArgument: ProjectDetailsArgument(
          projectEntity: projectEntity,
          projectId: "0",
        ),
      );
}
