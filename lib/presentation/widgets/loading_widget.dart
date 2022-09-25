import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Lottie.asset(
        AssetsConstants.loading,
        frameRate: FrameRate.max,
      );
}
