import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../themes/theme_color.dart';

class OverViewSection extends StatelessWidget {
  final String description;
  const OverViewSection({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.only(bottom: Sizes.dimen_2.h),
          child: Text(
            TranslateConstants.overview.t(context),
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: AppColor.absoluteTransparentGeeBung,
            ),
          ),
        ),

        Text(
         description,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: AppColor.geeBung
          ),
        ),
      ],
    );
  }
}
