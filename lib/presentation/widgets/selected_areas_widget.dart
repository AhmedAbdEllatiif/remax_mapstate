import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';

import '../themes/theme_color.dart';

class SelectedAreasWidget extends StatelessWidget {
  final Function() onAddAreaPressed;
  final Function(Object? value) onRemoveAreaPressed;
  final List<AreaEntity> selectedAreas;

  const SelectedAreasWidget({
    Key? key,
    required this.onAddAreaPressed,
    required this.selectedAreas,
    required this.onRemoveAreaPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// text & icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              TranslateConstants.selectedAreas.t(context),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: AppColor.geeBung, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: AppColor.geeBung,
              ),
              onPressed: onAddAreaPressed,
            ),
          ],
        ),

        /// selected areas list
        Card(
          color: AppColor.extraTransparentGeeBung,
          child: MultiSelectChipDisplay(
            icon: const Icon(Icons.close),
            chipColor: AppColor.geeBung,
            textStyle: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: AppColor.black, fontWeight: FontWeight.bold),
            items:
                selectedAreas.map((e) => MultiSelectItem(e, e.title)).toList(),
            onTap: (value) => onRemoveAreaPressed(value),
          ),
        ),
      ],
    );
  }
}
