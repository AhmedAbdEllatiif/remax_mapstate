import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/presentation/journeys/home/projects_status/project_status_backdrop_widget.dart';
import 'package:remax_mapstate/presentation/journeys/home/projects_status/project_status_page_view.dart';
import 'package:remax_mapstate/presentation/journeys/home/projects_status/top_project_data.dart';
import 'package:remax_mapstate/presentation/widgets/separator.dart';

import '../../../logic/bloc/project_status/project_status_bloc.dart';
import '../../../logic/cubit/language/language_cubit.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/loading_widget.dart';

class ProjectStatusWidget extends StatelessWidget {
  const ProjectStatusWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectStatusBloc, ProjectStatusState>(
      builder: (_, state) {
        /// loading
        if (state is LoadingProjectStatus) {
          return const Center(
            child: LoadingWidget(),
          );
        }

        /// error
         if (state is ErrorLoadingProjectStatus) {
          return Center(
            child: AppErrorWidget(
              appTypeError: state.appError.appErrorType,
              onPressedRetry: () => _fetchProjectStatus(context),
            ),
          );
        }

        /// empty
        if(state is EmptyProjectStatus){
          return Stack(
            fit: StackFit.expand,
            children: [
              // backdrop image of project
              const ProjectStatusBackDropWidget(),

              // scroll view with projects
              Column(
                children: [
                  // scroll view with top projects
                  ProjectStatusPageView(
                    projectStatusList: [state.projectStatusEntity],
                    initialPage: 0,
                  ),

                  // project data
                  const ProjectStatusDataWidget(),

                  // separator
                  const Separator(),
                ],
              ),
            ],
          );
        }


        /// fetched
        if (state is ProjectStatusLoadedState) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // backdrop image of project
              const ProjectStatusBackDropWidget(),

              // scroll view with projects
              Column(
                children: [
                  // scroll view with top projects
                  ProjectStatusPageView(
                    projectStatusList: state.projectStatusList,
                    initialPage: state.defaultIndex,
                  ),

                  // project data
                  const ProjectStatusDataWidget(),

                  // separator
                  const Separator(),
                ],
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  /// To fetch project status
  void _fetchProjectStatus(BuildContext context) =>
      context.read<ProjectStatusBloc>().add(LoadProjectStatusEvent(
            languageCode: context.read<LanguageCubit>().state.languageCode,
          ));
}
