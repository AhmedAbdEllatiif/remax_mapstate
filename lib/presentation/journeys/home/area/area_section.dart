import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/journeys/home/area/area_grid_view.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

class AreaSectionWidget extends StatelessWidget {

  final List<AreaEntity> areas;

  const AreaSectionWidget({Key? key, required this.areas}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left:  Sizes.dimen_4.w),
            child: Text("Project Area",
            style: Theme.of(context).textTheme.geryHeadLine6,),
          ),

           Expanded(child: Padding(
            padding:  EdgeInsets.only(top: Sizes.dimen_4.h),
            child: AreaGridView(areas:areas),
          )),
        ],
      ),
    );
  }
}
