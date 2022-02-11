import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';


class EmptyListWidget extends StatelessWidget {

  final String text;

  const EmptyListWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      constraints: BoxConstraints(maxWidth: ScreenUtil.screenWidth *0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          /// animation
          Lottie.asset(
            AssetsConstants.emptyBox,
            frameRate: FrameRate.max,
          ),

          const SizedBox(height: 10,),

          /// Text
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.whiteSubtitle1,
          )
        ],
      ),
    );
  }
}
