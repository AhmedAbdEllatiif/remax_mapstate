import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/bloc/areas_bloc/areas_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/project_backdrop/project_backdrop_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/top_projects/top_projects_bloc.dart';
import 'package:remax_mapstate/presentation/journeys/home/area/area_section.dart';
import 'package:remax_mapstate/presentation/journeys/home/top_projects/top_projects_widget.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/loading_animation_widget.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TopProjectsBloc _topProjectsBloc;
  late ProjectBackdropBloc _backdropBloc;
  late AreasBloc _areasBloc;

  @override
  void initState() {
    super.initState();
    _topProjectsBloc = getItInstance<TopProjectsBloc>();
    _topProjectsBloc.add(const LoadTopProjectsEvent());

    _backdropBloc = _topProjectsBloc.backdropBloc;

    _areasBloc = getItInstance<AreasBloc>();
    _areasBloc.add(LoadAreasEvent());
  }

  @override
  void dispose() {
    _topProjectsBloc.close();
    _backdropBloc.close();
    _areasBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _topProjectsBloc,
        ),
        BlocProvider(create: (context) => _backdropBloc),
        BlocProvider(create: (context) => _areasBloc),
      ],
      child: BlocBuilder<TopProjectsBloc, TopProjectsState>(
        builder: (context, state) {
          /// TopProjectsLoading
          if (state is TopProjectsLoading) {
            return const Center(
              child: LoadingAnimationWidget(),
            );
          }

          /// TopProjectsLoadedState
          else if (state is TopProjectsLoadedState) {
            return Stack(
              fit: StackFit.expand,
              children: [
                FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.6,
                  child: TopProjectWidget(
                    projects: state.projects,
                    defaultIndex: state.defaultIndex,
                  ),
                ),

                /// AreaSectionWidget
                const FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.4,
                    child: AreaSectionWidget(

                    ),

                    // child: Placeholder(color: AppColor.royalBlue,),
                    ),
              ],
            );
          }

          /// ErrorLoadingTopProjects
          else if (state is ErrorLoadingTopProjects) {
            return Center(
              child: Text(
                  "Error: ${state.appError.appErrorType}, Message: ${state.appError.message}"),
            );
          }

          return const Center(child: Text("Else To Show"));
        },
      ),
    );
  }
}
