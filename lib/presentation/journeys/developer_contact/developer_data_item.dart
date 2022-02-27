import 'package:flutter/material.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';


class DeveloperDataItem extends StatelessWidget {
  final String dataKey;
  final dynamic value;

  const DeveloperDataItem({Key? key, required this.dataKey, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// key
        Text(
          dataKey,
          style: Theme.of(context).textTheme.geryCaption,
        ),

        /// value
        Text(
          value,
          style: Theme.of(context).textTheme.boldVulcanBodyText2,
        ),
      ],
    );
  }
}
