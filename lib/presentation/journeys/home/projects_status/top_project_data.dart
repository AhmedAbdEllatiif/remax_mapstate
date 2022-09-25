import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';

import '../../../logic/bloc/project_status_backdrop/project_status_backdrop_bloc.dart';

class ProjectStatusDataWidget extends StatelessWidget {
  const ProjectStatusDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ProjectStatusBackdropBloc, ProjectStatusBackdropState>(
      builder: (blocContext,state){
        if (state is ProjectBackdropChangedState){
          return Text(
            _getText(context,state.projectStatusEntity.name),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppColor.geeBung,
              fontWeight: FontWeight.w300,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// To translate the default name if the received list from server is empty
  String _getText(BuildContext context,String name){
    if(name == TranslateConstants.allProjects){
      return TranslateConstants.allProjects.t(context);
    }
    return  name;
  }
}
