import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/project_status_backdrop/project_status_backdrop_bloc.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

class TopProjectDataWidget extends StatelessWidget {
  const TopProjectDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ProjectStatusBackdropBloc, ProjectStatusBackdropState>(
      builder: (blocContext,state){
        if (state is ProjectBackdropChangedState){
          return Text(
            state.projectStatusEntity.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppColor.vulcan,
              fontWeight: FontWeight.w300,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
