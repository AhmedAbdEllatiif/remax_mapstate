import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class ProjectStartingPriceSection extends StatelessWidget {

  final String startingPrice;

  const ProjectStartingPriceSection({Key? key, required this.startingPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      color: Colors.white70,
      width: ScreenUtil.screenWidth,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w,vertical: Sizes.dimen_4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(TranslateConstants.startingPrice,
              style: Theme.of(context).textTheme.vulcanCaption,),
            Text('1,927,000 EGP',style: Theme.of(context).textTheme.letterSpaceHeadLine6),

          ],
        ),
      ),
    );
  }
}
