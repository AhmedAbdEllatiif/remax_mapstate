import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/journeys/home/area/area_card.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AreaGridView extends StatelessWidget {
  final List<AreaEntity> areas;

  const AreaGridView({Key? key, required this.areas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: areas.length,
          physics: const BouncingScrollPhysics(),
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 2,
          //   mainAxisSpacing: Sizes.dimen_8.w,
          //   //childAspectRatio: 0.9,
          //   childAspectRatio: ResponsiveValue<double>(context,
          //       defaultValue: 0.9,
          //       valueWhen: const [
          //         Condition.equals(name: TABLET, value: 0.7),
          //         Condition.largerThan(name: TABLET, value: 0.7),
          //         Condition.equals(name: MOBILE, value: 0.9),
          //         Condition.smallerThan(name: MOBILE, value: 0.9),
          //       ]).value!,
          //   crossAxisSpacing: Sizes.dimen_8.w,
          // ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth > 700 ? 3 : 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.98,
          ),
          itemBuilder: (context, index) {
            if (index == 1) {
              return AreaCardWidget(
                area: areas[3],
              );
            }
            if (index == 2) {
              return AreaCardWidget(
                area: areas[1],
              );
            }
            if (index == 3) {
              return AreaCardWidget(
                area: areas[4],
              );
            }
            if (index == 4) {
              return AreaCardWidget(
                area: areas[2],
              );
            }
            return AreaCardWidget(
              area: areas[index],
            );
          });
    });
  }
}
