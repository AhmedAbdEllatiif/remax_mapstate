import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class OverViewSection extends StatelessWidget {
  const OverViewSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TranslateConstants.overview.t(context),
          style: Theme.of(context).textTheme.violetSubTitle2,),

        Container(margin: const EdgeInsets.only(top: 5,bottom: 0),),
        Text(
          TranslateConstants.test.t(context),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.blackBodyText2,
        ),

      ],
    );
  }
}
