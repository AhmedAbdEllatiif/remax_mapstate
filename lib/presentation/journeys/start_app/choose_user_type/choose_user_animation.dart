import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/constants/assets_constants.dart';

class ChooseUserAnimation extends StatelessWidget {
  const ChooseUserAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Lottie.asset(
    AssetsConstants.chooseUserLotti,
    frameRate: FrameRate.max,
  );
}
