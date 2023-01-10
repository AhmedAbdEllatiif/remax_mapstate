import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/journeys/home/projects_status/card_with_different_broder_color.dart';
import 'package:remax_mapstate/presentation/journeys/home/projects_status/project_status_backdrop_widget.dart';
import 'package:remax_mapstate/presentation/journeys/home/projects_status/project_status_page_view.dart';
import 'package:remax_mapstate/presentation/journeys/home/projects_status/top_project_data.dart';
import 'package:remax_mapstate/presentation/widgets/see_all_widget.dart';
import 'package:remax_mapstate/presentation/widgets/separator.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/screen_utils/screen_util.dart';
import '../../../../domain/entities/project_status_entity.dart';
import '../../../../router/route_hepler.dart';
import '../../../arguments/project_by_status_args.dart';
import '../../../logic/bloc/project_status/project_status_bloc.dart';
import '../../../logic/cubit/language/language_cubit.dart';
import '../../../themes/theme_color.dart';
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
        if (state is EmptyProjectStatus) {
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
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                child: SeeAllWidget(
                  title: TranslateConstants.findProjectByStatus.t(context),
                  onSeeAllPressed: () {},
                ),
              ),

              /// sizedBox to limit the height of the listView.builder
              Container(
                height: ScreenUtil.screenHeight * 0.35,
                padding: EdgeInsets.only(top: 8),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.projectStatusList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _navigateToProjectByStatusScreen(
                        context,
                        projectStatusEntity: state.projectStatusList[index],
                      ),
                      child: CardWithDifferentBorderColor(
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  state.projectStatusList[index].name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        height: 1.1,
                                      ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  _navigateToProjectByStatusScreen(
                                    context,
                                    projectStatusEntity:
                                        state.projectStatusList[index],
                                  );
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  constraints: BoxConstraints(
                                    maxHeight: ScreenUtil.screenHeight * 0.30,
                                  ),
                                  child: Image.asset(
                                    state.projectStatusList[index].image,
                                    //height: 100,
                                    // width: 200,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  /// to navigate to ProjectDetailsScreen
  void _navigateToProjectByStatusScreen(BuildContext context,
      {required ProjectStatusEntity projectStatusEntity}) {
    if (projectStatusEntity.name == "Oppurtunities" ||
        projectStatusEntity.name == "Offers") {
      RouteHelper().projectsByStatus(
        context,
        projectByStatusArguments: ProjectByStatusArguments(
          projectStatusEntity: projectStatusEntity,
        ),
      );
    } else {
      RouteHelper().areasByStatusScreen(
        context,
        projectByStatusArguments: ProjectByStatusArguments(
          projectStatusEntity: projectStatusEntity,
        ),
      );
    }
  }

  /// To fetch project status
  void _fetchProjectStatus(BuildContext context) =>
      context.read<ProjectStatusBloc>().add(LoadProjectStatusEvent(
            languageCode: context.read<LanguageCubit>().state.languageCode,
          ));
}
