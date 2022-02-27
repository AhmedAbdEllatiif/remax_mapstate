import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../common/constants/assets_constants.dart';

class NotUserAnimation extends StatelessWidget {
  const NotUserAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  => Lottie.asset(
    AssetsConstants.notUserAnimation,
    frameRate: FrameRate.max,
  );
}
