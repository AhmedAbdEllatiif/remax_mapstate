import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/presentation/bloc/project_status_backdrop/project_status_backdrop_bloc.dart';

class ProjectBackDropWidget extends StatelessWidget {
  const ProjectBackDropWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(Sizes.dimen_40.w)
        ),
        child: Stack(
          children:[
            FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 1,
              child: BlocBuilder<ProjectStatusBackdropBloc, ProjectStatusBackdropState>(
                builder: (context, state) {
                  if (state is ProjectBackdropChangedState) {
                    final imageUrl = state.projectStatusEntity.image;

                    return  Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    );
                    /*return CachedNetworkImage(
                      imageUrl: "${ApiConstants.BASE_IMAGE_URL}$posterPath",
                      fit: BoxFit.cover,
                    );*/
                  }else{
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),

            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0,sigmaY: 3.0,),
              child: Container(
                width: ScreenUtil.screenWidth,
                height: 200,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}