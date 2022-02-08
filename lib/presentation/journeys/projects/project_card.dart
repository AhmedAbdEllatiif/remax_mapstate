import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/argument_constants.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_details_argument.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/router/app_router.dart';

class ProjectCardWidget extends StatelessWidget {
  const ProjectCardWidget({Key? key}) : super(key: key);

  /// to navigate to ProjectDetailsScreen
  void _navigateToProjectsScreen(BuildContext context) =>
      Navigator.of(context).pushNamed(AppRouter.projectDetailsScreen, arguments: {
        ArgumentConstants.projectDetails: ProjectDetailsArgument(projectId: 0,),
      });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> _navigateToProjectsScreen(context),
      child: SizedBox(
        height: Sizes.dimen_100.h,
        width: ScreenUtil.screenWidth,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 1,
          //color: colors[index],
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,

          // stack
          child: Stack(
            children: [

              // grid tile
              GridTile(
                  child: Image.asset(
                    AssetsConstants.mountainViewImagePath,
                    fit: BoxFit.cover,
                  ),

                  // grid tile footer
                  footer: Container(
                    color: Colors.grey,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        /// Row (Avatar and District data)
                        Row(
                          children: [
                            /// Avatar Image
                            const CircleAvatar(
                              backgroundImage:
                              AssetImage(AssetsConstants.mountainViewImagePath),
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
                                  style: Theme.of(context).textTheme.whiteCaption,
                                )
                              ],
                            )
                          ],
                        ),

                        /// Column of Starting price
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text(
                              TranslateConstants.startingPrice.t(context).intelliTrim_14(),
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

              /// favorite icon
               Positioned(
                  top: Sizes.dimen_18.w,
                  right:  Sizes.dimen_18.w,
                  child: const Icon(
                    Icons.star_border_purple500_outlined,
                    color: AppColor.royalBlue,
                  )),
            ],
          ),

        ),
      ),
    );
  }
}
