import 'package:flutter/material.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class DeveloperDataItem extends StatelessWidget {
  final String dataKey;
  final dynamic value;
  final bool isLocation;

  const DeveloperDataItem(
      {Key? key, required this.dataKey, this.value, this.isLocation = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          dataKey,
          style: Theme.of(context).textTheme.geryCaption,
        ),
        Text(
          value,
          style: isLocation
              ? Theme.of(context).textTheme.boldVulcanBodyText2.copyWith(
                    color: AppColor.royalBlue,
                  )
              : Theme.of(context).textTheme.boldVulcanBodyText2,
        ),
      ],
    );
  }
}
