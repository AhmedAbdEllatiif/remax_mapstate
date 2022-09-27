import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class ProjectStartingPriceSection extends StatelessWidget {

  final String startingPrice;

  const ProjectStartingPriceSection({Key? key, required this.startingPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      color: AppColor.fadeBlack,
      width: ScreenUtil.screenWidth,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w,vertical: Sizes.dimen_4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TranslateConstants.startingPrice.t(context),
              style: Theme.of(context).textTheme.caption!.copyWith(
                color: AppColor.absoluteTransparentGeeBung,
              ),),
            Text(startingPrice,style: Theme.of(context).textTheme.letterSpaceHeadLine6.copyWith(
              color: AppColor.geeBung
            )),

          ],
        ),
      ),
    );
  }
}
