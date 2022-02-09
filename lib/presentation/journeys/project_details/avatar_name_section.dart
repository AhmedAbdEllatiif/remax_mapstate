import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class ProjectAvatarNameSection extends StatelessWidget {

  final String name;
  final String avatarUrl;
  final String district;

  const ProjectAvatarNameSection({Key? key, required this.name, required this.avatarUrl, required this.district}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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

        const Icon(Icons.favorite_border,color: AppColor.royalBlue,),

        /// Column of Starting price
        /*  Column(
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
                  )*/
      ],
    );
  }
}
