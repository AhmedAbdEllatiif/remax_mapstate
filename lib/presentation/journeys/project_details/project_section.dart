import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/project_details/project_data_item_card.dart';

class ProjectDataSection extends StatelessWidget {
  final String planPercentage, planYears, startingArea, deliveryYear;

  const ProjectDataSection({
    Key? key,
    required this.startingArea,
    required this.deliveryYear,
    required this.planPercentage,
    required this.planYears,
  }) : super(key: key);

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
              data:
                  '$planPercentage% - $planYears ${TranslateConstants.years.t(context)}',
            ),
            ProjectDataItemCard(
              title: TranslateConstants.deliveryYear.t(context),
              data: deliveryYear,
            )
          ],
        ),
        ProjectDataItemCard(
          title: TranslateConstants.startingArea.t(context),
          data: startingArea,
        ),
      ],
    );
  }
}
