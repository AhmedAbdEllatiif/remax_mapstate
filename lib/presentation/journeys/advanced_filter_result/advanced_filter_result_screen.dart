import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/presentation/arguments/advanced_filter_result_args.dart';
import 'package:remax_mapstate/presentation/logic/cubit/advanced_filter_projects/advanced_filter_projects_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/app_error_widget.dart';
import 'package:remax_mapstate/presentation/widgets/empty_list_widegt.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/presentation/widgets/project_item_widget.dart';

import '../../../common/constants/translate_constatns.dart';
import '../../../router/route_hepler.dart';
import '../../logic/cubit/advanced_filter_builder/advanced_filter_builder_cubit.dart';
import 'loading_more_result_projects.dart';

class AdvancedFilterResultScreen extends StatefulWidget {
  final AdvancedFilterResultArgs arguments;

  const AdvancedFilterResultScreen({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<AdvancedFilterResultScreen> createState() =>
      _AdvancedFilterResultScreenState();
}

class _AdvancedFilterResultScreenState
    extends State<AdvancedFilterResultScreen> {
  // projects list
  final List<ProjectEntity> projects = [];

  // ScrollController
  late final ScrollController _controller;

  // AdvancedFilterProjectsCubit
  late final AdvancedFilterProjectsCubit _advancedFilterProjectsCubit;

  @override
  void initState() {
    super.initState();
    _advancedFilterProjectsCubit = getItInstance<AdvancedFilterProjectsCubit>();
    _controller = ScrollController();
    _listenerOnScrollController();
    _searchProjects();
  }

  @override
  void dispose() {
    final AdvancedFilterBuilderCubit advancedFilterBuilderCubit =
    getItInstance<AdvancedFilterBuilderCubit>();
    advancedFilterBuilderCubit.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _advancedFilterProjectsCubit,
      child: Scaffold(

        /// appBar
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                TranslateConstants.searchResult.t(context),
              ),
              BlocBuilder<AdvancedFilterProjectsCubit,
                  AdvancedFilterProjectsState>(
                builder: (context, state) {
                  return Text(
                    "\" ${projects.length} \"",
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: AppColor.fadeGeeBung),
                  );
                },
              ),
            ],
          ),
        ),

        /// body
        body: BlocListener<AdvancedFilterProjectsCubit,
            AdvancedFilterProjectsState>(
          listener: (context, state) {
            if (state is AdvancedFilterProjectsFetched) {
              projects.addAll(state.projects);
            }
            if (state is LastPageAdvancedFilterProjectsReached) {
              projects.addAll(state.projects);
            }
          },
          child: BlocBuilder<AdvancedFilterProjectsCubit,
              AdvancedFilterProjectsState>(
            builder: (context, state) {
              //==> loading
              if (state is LoadingAdvancedFilterProjects) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              //==> unAuthorized
              if (state is UnAuthorizedFilterProjects) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: AppErrorType.unAuthorized,
                    onPressedRetry: () => _navigateToChooseUserScreen(context),
                  ),
                );
              }

              //==> error
              if (state is ErrorWhileLoadingAdvancedFilterProjects) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    buttonText: TranslateConstants.retry.t(context),
                    onPressedRetry: () => _searchProjects(),
                  ),
                );
              }

              return ListView.separated(
                shrinkWrap: true,
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  right: AppUtils.listHorizontalPadding.w,
                  left: AppUtils.listHorizontalPadding.w,
                  bottom: 10,
                ),
                //==> itemCount
                itemCount: projects.length + 1,

                //==> separatorBuilder
                separatorBuilder: (_, __) => const SizedBox(height: 10),

                //==> itemBuilder
                itemBuilder: (_, index) {
                  if (index < projects.length) {
                    return ProjectItemWidget(
                      projectEntity: projects[index],
                    );
                  }

                  /// loading or end of list
                  return LoadingMoreResultProjectsWidget(
                    advancedFilterProjectsCubit: _advancedFilterProjectsCubit,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// search for more projects
  void _searchProjects() {
    _advancedFilterProjectsCubit.searchProjects(context,
        filters: widget.arguments.filters,
        limit: 5,
        currentListLength: projects.length);
  }

  /// listener on controller
  /// when last item reached fetch next page of projects
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_advancedFilterProjectsCubit.state
        is! LastPageAdvancedFilterProjectsReached) {
          _searchProjects();
        }
      }
    });
  }

  /// To navigate to chooseUserScreen
  void _navigateToChooseUserScreen(BuildContext context) {
    RouteHelper().chooseUserTypeScreen(context, isClearStack: true);
  }
}
