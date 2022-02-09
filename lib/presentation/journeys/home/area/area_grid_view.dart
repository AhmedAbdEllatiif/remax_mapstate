import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/journeys/home/area/area_card.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class AreaGridView extends StatelessWidget {
  final List<AreaEntity> areas;
  const AreaGridView({Key? key, required this.areas}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: areas.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing:  Sizes.dimen_8.w,
          //childAspectRatio: 0.9,
          childAspectRatio: ResponsiveValue<double>(context,defaultValue: 0.9,valueWhen: const [
            Condition.equals(
                name: TABLET, value:0.7),
            Condition.largerThan(
                name: TABLET, value: 0.7),
            Condition.equals(
                name: MOBILE, value: 0.9),
            Condition.smallerThan(
                name: MOBILE, value: 0.9),
          ]).value!,
          crossAxisSpacing: Sizes.dimen_8.w,
        ),
        itemBuilder: (context, index) {
          return  AreaCardWidget(area: areas[index],);
        });
  }
}
