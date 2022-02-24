import 'package:flutter/material.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../../common/constants/assets_constants.dart';

class Logo extends StatelessWidget {

  final double height;

  const Logo({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsConstants.whiteLogo,
      fit: BoxFit.cover,
      color: AppColor.vulcan,
    );
  }
}
