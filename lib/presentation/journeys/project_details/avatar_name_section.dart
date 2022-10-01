import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../common/constants/sizes.dart';
import '../../widgets/cached_image_widget.dart';

class ProjectAvatarNameSection extends StatelessWidget {
  final String name;
  final String avatarUrl;
  final String developerName;

  const ProjectAvatarNameSection({
    Key? key,
    required this.name,
    required this.avatarUrl,
    required this.developerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Row (Avatar and District data)
        Expanded(
          child: Row(
            children: [
              /// Avatar Image
              CachedImageWidget(
                imageUrl: avatarUrl,
                height: 50,
                width: 50,
                progressBarScale: 0.7,
                isCircle: true,
              ),

              // SizedBox
               SizedBox(
                width: Sizes.dimen_10.w,
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: AppColor.geeBung,
                          ),
                    ),
                    Text(
                      developerName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: AppColor.fadeGeeBung,
                          ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        const Icon(
          Icons.favorite_border,
          color: AppColor.geeBung,
        ),

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
