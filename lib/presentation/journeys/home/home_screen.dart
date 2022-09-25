import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/enums/app_language.dart';
import 'package:remax_mapstate/data/data_sources/remote_data_source.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/presentation/journeys/home/area/area_section.dart';
import 'package:remax_mapstate/presentation/journeys/home/top_projects/top_projects_widget.dart';
import 'package:remax_mapstate/presentation/logic/cubit/language/language_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_error_widget.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../logic/cubit/areas/areas_cubit.dart';
import '../../logic/bloc/project_status/project_status_bloc.dart';
import '../../logic/bloc/project_status_backdrop/project_status_backdrop_bloc.dart';
import '../../logic/cubit/projects/get_projects_cubit.dart';

class ProductEdge {
  final String id;
  final String edgeName;

  const ProductEdge({
    required this.id,
    required this.edgeName,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProjectStatusBloc _projectStatusBloc;
  late ProjectStatusBackdropBloc _backdropBloc;
  late AreasCubit _areasCubit;

  @override
  void initState() {
    super.initState();

    _projectStatusBloc = getItInstance<ProjectStatusBloc>();

    _projectStatusBloc.add(const LoadProjectStatusEvent());

    _backdropBloc = _projectStatusBloc.backdropBloc;

    _areasCubit = getItInstance<AreasCubit>();
    _fetchAreas();
  }

  @override
  void dispose() {
    _backdropBloc.close();
    _areasCubit.close();
    _projectStatusBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // listen on language changes
    return BlocListener<LanguageCubit, Locale>(
      listenWhen: (old, recent) {
        return old != recent;
      },
      listener: (context, state) {
        _fetchAreas();
      },

      // screen content
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: _projectStatusBloc,
          ),
          BlocProvider(create: (context) => _backdropBloc),
          BlocProvider(create: (context) => _areasCubit),
        ],
        child: BlocBuilder<ProjectStatusBloc, ProjectStatusState>(
          builder: (context, state) {
            /// TopProjectsLoading
            if (state is LoadingProjects) {
              return const Center(
                child: LoadingWidget(),
              );
            }

            /// TopProjectsLoadedState
            else if (state is ProjectStatusLoadedState) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.6,
                    child: TopProjectWidget(
                      projectStausList: state.projectStatus,
                      defaultIndex: state.defaultIndex,
                    ),
                  ),

                  /// AreaSectionWidget
                  const FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.4,
                    child: AreaSectionWidget(),

                    // child: Placeholder(color: AppColor.royalBlue,),
                  ),
                ],
              );
            }

            /// ErrorLoadingTopProjects
            else if (state is ErrorLoadingProjectStatus) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () {},
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  /// To fetch areas
  void _fetchAreas() {
    _areasCubit.fetchAreas(context, limit: 6);
  }
}
