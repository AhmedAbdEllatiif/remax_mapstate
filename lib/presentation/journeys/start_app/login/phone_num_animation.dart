import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/constants/assets_constants.dart';

class PhoneNumAnimation extends StatelessWidget {
  const PhoneNumAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Lottie.asset(
    AssetsConstants.phoneNumLotti,
    frameRate: FrameRate.max,
  );
}
