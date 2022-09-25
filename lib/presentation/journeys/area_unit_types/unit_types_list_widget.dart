import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/area_unit_types/unit_type_card_widget.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../domain/entities/unit_type_entity.dart';

class UnitTypeListWidget extends StatelessWidget {
  final List<UnitTypeEntity> unitTypeList;

  const UnitTypeListWidget({Key? key, required this.unitTypeList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: unitTypeList.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: Sizes.dimen_20.w,
          // childAspectRatio: 1.0,
          childAspectRatio: ResponsiveValue<double>(context,
              defaultValue: 1.0,
              valueWhen: const [
                Condition.equals(name: TABLET, value: 1.2),
                Condition.largerThan(name: TABLET, value: 1.2),
                Condition.equals(name: MOBILE, value: 1.0),
                Condition.smallerThan(name: MOBILE, value: 1.0),
              ]).value!,
          crossAxisSpacing: Sizes.dimen_20.w,
        ),
        itemBuilder: (context, index) {
          return  UnitTypeCardWidget(unitTypeName: unitTypeList[index].name,);
        });
  }
}
