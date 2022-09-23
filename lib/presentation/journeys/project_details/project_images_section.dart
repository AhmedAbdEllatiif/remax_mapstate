import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/assets_constants.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../logic/cubit/project_scrollable_indicator/indicator_position_cubit.dart';

class ProjectImagesSection extends StatefulWidget {
  ProjectImagesSection({Key? key}) : super(key: key);

  @override
  State<ProjectImagesSection> createState() => _ProjectImagesSectionState();
}

class _ProjectImagesSectionState extends State<ProjectImagesSection> {
  late final PageController _pageController;

  late final IndicatorPositionCubit indicatorPositionCubit;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      keepPage: false,
      //viewportFraction: 0.7,
    );

    /// init indicatorPositionCubit
    indicatorPositionCubit = getItInstance<IndicatorPositionCubit>();
  }

  @override
  void dispose() {
    indicatorPositionCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => indicatorPositionCubit,
      child: SizedBox(
        width: ScreenUtil.screenWidth,
        //height: ScreenUtil.screenHeight * 0.6,
        height: ScreenUtil.screenHeight * ResponsiveValue<double>(
            context,
            defaultValue: 0.35,
            valueWhen: const [
              Condition.equals(
                  name: TABLET, value: 0.4),
              Condition.largerThan(
                  name: TABLET, value: 0.4),
              Condition.equals(
                  name: MOBILE, value: 0.5),
              Condition.smallerThan(
                  name: MOBILE, value: 0.6),
            ]
        ).value!,
        child: Stack(
          fit: StackFit.expand,
          children: [


            /// Images PageView
            PageView.builder(
              physics: const BouncingScrollPhysics(),
              pageSnapping: true,
              controller: _pageController,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ProjectImageCard(
                    imageUrl: AssetsConstants.mountainViewImagePath);
              },
              onPageChanged: (index) {
                indicatorPositionCubit.updatePosition(index.toDouble());
              },
            ),

            /// Indicator
            Positioned(
              left: 0,
              right: 0,
              bottom: 2,
              child: BlocBuilder<IndicatorPositionCubit, IndicatorPositionState>(
                builder: (context, state) {
                  return DotsIndicator(
                    dotsCount: 5,
                    position: state.currentPosition,
                    decorator: DotsDecorator(
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: AppColor.black,
                      // Inactive color
                      activeColor: AppColor.geeBung,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProjectImageCard extends StatelessWidget {
  final String imageUrl;

  const ProjectImageCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
