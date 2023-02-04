import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/functions/get_authorized_user.dart';
import 'package:remax_mapstate/common/functions/get_user_token.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/presentation/journeys/favorite/load_more_fav_projects.dart';
import 'package:remax_mapstate/presentation/logic/cubit/fav_projects/get_fav_projects_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_error_widget.dart';
import 'package:remax_mapstate/presentation/widgets/empty_list_widegt.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/widgets/project_item_widget.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../../domain/entities/project_entity.dart';
import '../../widgets/app_refersh_indicator.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  /// GetFavProjectsCubit
  late GetFavProjectsCubit _getFavProjectsCubit;

  /// projects list
  final List<ProjectEntity> _projectsList = [];

  /// ScrollController
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    // init _getFavProjectsCubit
    _getFavProjectsCubit = getItInstance<GetFavProjectsCubit>();

    // init ScrollController
    _controller = ScrollController();

    _fetchFavProjects();

    _listenerOnScrollController();
  }

  @override
  void dispose() {
    _getFavProjectsCubit.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getFavProjectsCubit,
      child: BlocConsumer<GetFavProjectsCubit, GetFavProjectsState>(
        /**
         * listener
         * */
        listener: (context, state) {
          if (state is FavProjectsFetched) {
            _projectsList.addAll(state.projects);
          }
          if (state is LastPageFavProjectsReached) {
            _projectsList.addAll(state.projects);
          }
        },

        /**
         * builder
         * */
        builder: (context, state) {
          /*
          *
          *
          * loading
          *
          *
          * */
          if (state is LoadingFavProjects) {
            return const Center(child: LoadingWidget());
          }

          /*
          *
          *
          * unAuthorized
          *
          *
          * */
          if (state is UnAuthorizedToFetchFavProjects) {
            return Center(
                child: AppErrorWidget(
              appTypeError: AppErrorType.unAuthorized,
              onPressedRetry: () => _navigateToLogin(),
            ));
          }

          /*
          *
          *
          * empty list
          *
          *
          * */
          if (state is EmptyFavProjects) {
            return Center(
                child: EmptyListWidget(
              text: TranslateConstants.noFavProjectsToShow.t(context),
            ));
          }

          /*
          *
          *
          * error
          *
          *
          * */
          if (state is ErrorWhileLoadingFavProjects) {
            return Center(
                child: AppErrorWidget(
              appTypeError: state.appError.appErrorType,
              onPressedRetry: () => _fetchFavProjects(),
            ));
          }

          /*
          *
          *
          * list
          *
          *
          * */
          return AppRefreshIndicator(
            onRefresh: () async {
              _projectsList.clear();
              _fetchFavProjects();
            },
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),

              //==> itemCount
              itemCount: _projectsList.length + 1,

              //==> separatorBuilder
              separatorBuilder: (_, __) => const SizedBox(height: 10),

              //==> itemBuilder
              itemBuilder: (_, index) {
                //==> return list item
                if (index < _projectsList.length) {
                  return ProjectItemWidget(
                    projectEntity: _projectsList[index],
                  );
                }

                //==> loading or end of list
                return LoadingMoreFavProjectsWidget(
                  getFavProjectsCubit: _getFavProjectsCubit,
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// to fetch fav projects list
  void _fetchFavProjects() {
    final userToken = getUserToken(context);
    final userId = getAuthorizedUser(context).id;

    _getFavProjectsCubit.fetchFavProjects(
      context,
      userToken: userToken,
      userId: userId,
      limit: 5,
      currentListLength: _projectsList.length,
    );
  }

  /// to navigate to login
  void _navigateToLogin() {
    RouteHelper().loginScreen(
      context,
    );
  }

  /// listener on controller
  /// when last item reached fetch next page of projects
  /// when last item reached no action needed
  void _listenerOnScrollController() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_getFavProjectsCubit.state is! LastPageFavProjectsReached) {
          _fetchFavProjects();
        }
      }
    });
  }
}
