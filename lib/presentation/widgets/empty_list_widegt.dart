import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class EmptyListWidget extends StatelessWidget {
  final String text;

  const EmptyListWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5!.copyWith(
              color: AppColor.geeBung,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
