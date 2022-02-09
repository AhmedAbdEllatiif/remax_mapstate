import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/project_backdrop/project_backdrop_bloc.dart';

class TopProjectDataWidget extends StatelessWidget {
  const TopProjectDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ProjectBackdropBloc, ProjectBackdropState>(
      builder: (blocContext,state){
        if (state is ProjectBackdropChangedState){
          return Text(
            state.projectEntity.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headline6,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
