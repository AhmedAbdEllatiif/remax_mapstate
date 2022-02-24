import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/argument_constants.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_argument.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../router/route_hepler.dart';

class ProjectCardWidget extends StatelessWidget {
  final ProjectEntity projectEntity;
  ///TODO remove this after testing is end
  final int testingIndex;

  const ProjectCardWidget({Key? key, required this.projectEntity, required this.testingIndex})
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
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        //color: colors[index],
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,

        // stack
        child: Stack(
          children: [
            // grid tile
            GestureDetector(
              onTap: () => _navigateToProjectsScreen(context),
              child: GridTile(
                  child: Image.asset(
                    AssetsConstants.mountainViewImagePath,
                    fit: BoxFit.cover,
                  ),

                  // grid tile footer
                  footer: Container(
                    color: AppColor.transparentVulcan,
                    height: ResponsiveValue<double>(context,
                        defaultValue: Sizes.dimen_24.h,
                        valueWhen: [
                          Condition.equals(
                              name: TABLET, value: Sizes.dimen_60.h),
                          Condition.largerThan(
                              name: TABLET, value: Sizes.dimen_60.h),
                          Condition.equals(
                              name: MOBILE, value: Sizes.dimen_24.h),
                          Condition.smallerThan(
                              name: MOBILE, value: Sizes.dimen_24.h),
                        ]).value,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Row (Avatar and District data)
                        Row(
                          children: [
                            /// Avatar Image
                            const CircleAvatar(
                              backgroundImage: AssetImage(
                                  AssetsConstants.mountainViewImagePath),
                            ),

                            // SizedBox
                            const SizedBox(
                              width: 5,
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cairo".intelliTrim(),
                                ),
                                Text(
                                  "New Cairo".intelliTrim(),
                                  style:
                                      Theme.of(context).textTheme.whiteCaption,
                                )
                              ],
                            )
                          ],
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
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Text(
                              "1,300,000",
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),

            /// favorite icon
            /*Positioned(
                top: Sizes.dimen_18.w,
                right: Sizes.dimen_18.w,
                child: BlocBuilder<FavoriteProjectsBloc,
                    FavoriteProjectsState>(
                  builder: (context, state) {
                    print("State:$state");
                    if (state is IsFavoriteProjectState) {
                      return GestureDetector(
                        onTap: () =>
                            BlocProvider.of<FavoriteProjectsBloc>(context)
                                .add(
                          ToggleFavoriteProjectEvent(
                            projectEntity: widget.projectEntity,
                            isFavorite: state.isProjectFavorite,
                          ),
                        ),
                        child: Icon(
                          state.isProjectFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColor.royalBlue,
                          size: Sizes.dimen_12.h,
                        ),
                      );
                    }
                    return const Icon(
                      Icons.star_border_purple500_outlined,
                      color: AppColor.royalBlue,
                    );
                  },
                )),*/
          ],
        ),
      ),
    );
  }

  /// to navigate to ProjectDetailsScreen
  /// to navigate to ProjectDetailsScreen
  void _navigateToProjectsScreen(BuildContext context) =>
      RouteHelper().projectDetailScreen(
        context,
        projectDetailsArgument : ProjectDetailsArgument(
          //projectId: projectEntity.id,
          projectId: testingIndex
        ),
      );

}
