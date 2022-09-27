import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
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
        Text(
          TranslateConstants.overview.t(context),
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
            color: AppColor.absoluteTransparentGeeBung,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 0),
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
