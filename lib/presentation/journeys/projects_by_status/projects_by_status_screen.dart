import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/presentation/arguments/project_by_status_args.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/project_item_widget.dart';
import 'package:remax_mapstate/presentation/logic/cubit/projects_by_status/projects_by_status_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_error_widget.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';

import 'loading_more_projects_by_status.dart';

class ProjectsByStatusScreen extends StatefulWidget {
  final ProjectByStatusArguments projectByStatusArguments;

  const ProjectsByStatusScreen(
      {Key? key, required this.projectByStatusArguments})
      : super(key: key);

  @override
  _ProjectsByStatusScreenState createState() => _ProjectsByStatusScreenState();
}

class _ProjectsByStatusScreenState extends State<ProjectsByStatusScreen> {
  late final String projectsStatusTitle;
  late final String areaName;

  late final String statusId;

  // ProjectsByStatusCubit
  late final ProjectsByStatusCubit _projectsByStatusCubit;

  // list of projects
  final List<ProjectEntity> projectsList = [];

  // ScrollController
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // init ProjectsByStatusCubit
    _projectsByStatusCubit = getItInstance<ProjectsByStatusCubit>();

    // init status
    statusId = widget.projectByStatusArguments.projectStatusEntity.id;

    // init title
    projectsStatusTitle =
        widget.projectByStatusArguments.projectStatusEntity.name;

    areaName = widget.projectByStatusArguments.areaName;

    // fetch the projects list
    _fetchProjects(limit: 10);

    /// listener on controller
    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _projectsByStatusCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _projectsByStatusCubit,
      child: BlocConsumer<ProjectsByStatusCubit, ProjectsByStatusState>(
        listener: (context, state) {
          if (state is ProjectsByStatusFetched) {
            projectsList.addAll(state.projects);
            print(
                "ProjectsByStatusScreen >> listener >> Projects >> ....\n${state.projects}\n......");
          }
          if (state is LastPageProjectsByStatusReached) {
            projectsList.addAll(state.projects);
            print(
                "ProjectsByStatusScreen >> listener >> Projects >> ....\n${state.projects}\n......");
          }
        },
        builder: (context, state) {
          return Scaffold(
            /// appBar title
            //appBarTitle: Text(title),
            appBar: AppBar(
              title: Column(
                children: [
                  Text(areaName),
                  Text(projectsStatusTitle,style: Theme.of(context).textTheme.caption!.copyWith(
                    color: AppColor.geeBung.withOpacity(0.9)
                  ),),
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_4.w),
              child: _body(state),
            ),
          );
        },
      ),
    );
  }

  /// return a widget of body according to current state
  Widget _body(ProjectsByStatusState state) {
    //==> loading
    if (state is LoadingProjectsByStatus) {
      return const Center(
        child: LoadingWidget(),
      );
    }

    //==> empty
    if (state is EmptyProjectsByStatus) {
      return const Center(
        child: Text("No projects found"),
      );
    }

    //==> error loading projects
    if (state is ErrorWhileLoadingProjectsByStatus) {
      return Center(
        child: AppErrorWidget(
          appTypeError: state.appError.appErrorType,
          onPressedRetry: () {
            _fetchProjects(limit: 10);
          },
        ),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      controller: _controller,
      itemCount: projectsList.length + 1,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: Sizes.dimen_5.h,
        );
      },
      itemBuilder: (context, index) {
        if (index < projectsList.length) {
          return ProjectItemWidget(
            projectEntity: projectsList[index],
          );
        }

        /// loading or end of list
        return LoadingMoreProjectsByStatusWidget(
          projectsByStatusCubit: _projectsByStatusCubit,
        );
      },
    );

    return const SizedBox.shrink();
  }

  /// To send request fetch projects
  void _fetchProjects({
    required int limit,
  }) {
    final currentListLength = projectsList.length;
    _projectsByStatusCubit.fetchProjectByStatus(
      context,
      statusId: statusId,
      areaId: widget.projectByStatusArguments.areaId,
      limit: limit,
      currentListLength: currentListLength,
    );
  }

  /// listener on controller
  /// when last item reached fetch next page of projects
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_projectsByStatusCubit.state is! LastPageProjectsByStatusReached) {
          _fetchProjects(limit: 2);
        }
      }
    });
  }
}
