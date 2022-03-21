import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
class ProjectDataItemCard extends StatelessWidget {

  final String title;
  final String data;


  const ProjectDataItemCard({Key? key, required this.title, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: Sizes.dimen_2.h),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.caption!.copyWith(
              color: AppColor.absoluteTransparentGeeBung
            ),
          ),

          Text(
            data,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
          color: AppColor.geeBung
            ),
          ),
        ],
      ),
    );
  }

}
