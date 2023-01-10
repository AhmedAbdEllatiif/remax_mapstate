import 'package:flutter/material.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/presentation/journeys/home/projects_status/project_status_item.dart';




class AnimatedProjectCard extends StatelessWidget {
  final int index;
  final ProjectStatusEntity statusEntity;
  final PageController pageController;

  const AnimatedProjectCard(
      {Key? key,
        required this.index,
    required this.statusEntity,
        required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget? child){
        double value =1;
        if(pageController.position.haveDimensions){
          value = pageController.page! - index;
          value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: Sizes.dimen_230.w,
              height: Curves.easeIn.transform(value) * ScreenUtil.screenHeight * 0.3,
              child: child,
            ),
          );
        }else{
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: Sizes.dimen_230.w,
              height: Curves.easeIn.transform(index == 0 ? value:value *.3 ) * ScreenUtil.screenHeight * 0.35,
              child: child,
            ),
          );
        }
      },
      child: ProjectStatusItem(
        statusEntity: statusEntity,
      ),
    );
  }
}