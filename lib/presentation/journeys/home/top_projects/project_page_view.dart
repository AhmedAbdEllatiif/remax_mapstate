import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/domain/entities/project_status_entity.dart';
import 'package:remax_mapstate/presentation/journeys/home/top_projects/animated_project_card.dart';

import '../../../logic/bloc/project_status_backdrop/project_status_backdrop_bloc.dart';

class ProjectPageView extends StatefulWidget {
  final List<ProjectStatusEntity> projectStatusList;
  final int initialPage;

  const ProjectPageView({
    Key? key,
    required this.projectStatusList,
    required this.initialPage,
  }) : super(key: key);

  @override
  _ProjectPageViewState createState() => _ProjectPageViewState();
}

class _ProjectPageViewState extends State<ProjectPageView> {
  late PageController _pageController;

  // viewportFraction how much screen share each item of pageView will take
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.initialPage,
      keepPage: false,
      viewportFraction: 0.7,
    );
  }


  @override
  Widget build(BuildContext context) {
    print("ProjectPageView PageView length >> ${widget.projectStatusList.length}");
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
      height: ScreenUtil.screenHeight * 0.35,
      child: PageView.builder(
        pageSnapping: true,
        controller: _pageController,
        itemCount: widget.projectStatusList.length,
        itemBuilder: (context, index) {
          final project = widget.projectStatusList[index];
          return AnimatedProjectCard(
            projectId: project.id,
            imagePath: project.image,
            index: index,
            pageController: _pageController,
          );
          /*return Container(
            height: 50,
            width: 100,
            color: Colors.black,
          );*/
        },
        onPageChanged: (index) {
          BlocProvider.of<ProjectStatusBackdropBloc>(context)
              .add(ProjectBackdropChangedEvent(projectStatusEntity: widget.projectStatusList[index]));
        },
      ),
    );
  }
}

