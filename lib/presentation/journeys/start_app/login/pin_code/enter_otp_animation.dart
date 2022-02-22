import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/constants/assets_constants.dart';

class EnterOtpAnimation extends StatelessWidget {
  const EnterOtpAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Lottie.asset(
    AssetsConstants.otpLotti,
    frameRate: FrameRate.max,
  );
}
