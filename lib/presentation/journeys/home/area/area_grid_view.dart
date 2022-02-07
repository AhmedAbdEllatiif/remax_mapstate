import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/journeys/home/area/area_card.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';

class AreaGridView extends StatelessWidget {
  final List<AreaEntity> areas;
  const AreaGridView({Key? key, required this.areas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: areas.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing:  Sizes.dimen_16.w,
            childAspectRatio: 0.7,
            crossAxisSpacing: Sizes.dimen_16.w,
          ),
          itemBuilder: (context, index) {
            return  AreaCardWidget(area: areas[index],);
          }),
    );
  }
}
