import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_data_item_card.dart';

class ProjectDataSection extends StatelessWidget {
  final String paymentPlan, startingArea, finishingType, deliveryYear;

  const ProjectDataSection({Key? key, required this.paymentPlan, required this.startingArea, required this.finishingType, required this.deliveryYear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProjectDataItemCard(
              title: TranslateConstants.paymentPlan.t(context),
              data: '10% - 8 years',
            ),
            ProjectDataItemCard(
              title: TranslateConstants.deliveryYear.t(context),
              data: '2022',
            )
          ],
        ),
        ProjectDataItemCard(
          title: TranslateConstants.startingArea.t(context),
          data: '95',
        ),
        ProjectDataItemCard(
          title: TranslateConstants.finishingType.t(context),
          data: 'Core & Shell',
        ),
      ],
    );
  }
}
