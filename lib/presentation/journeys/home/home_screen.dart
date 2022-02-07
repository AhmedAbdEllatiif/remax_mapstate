import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/bloc/areas_bloc/areas_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/project_backdrop/project_backdrop_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/top_projects/top_projects_bloc.dart';
import 'package:remax_mapstate/presentation/journeys/home/area/area_section.dart';
import 'package:remax_mapstate/presentation/journeys/home/top_projects/top_projects_widget.dart';

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
        BlocProvider(create: (context) => _topProjectsBloc),
        BlocProvider(create: (context) => _backdropBloc),
        BlocProvider(create: (context) => _areasBloc),
      ],
      child: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.6,
            child: BlocBuilder<TopProjectsBloc, TopProjectsState>(
              builder: (context, state) {
                /// TopProjectsLoading
                if (state is TopProjectsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      value: 15,
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  );
                }

                /// TopProjectsLoadedState
                else if (state is TopProjectsLoadedState) {
                  return TopProjectWidget(
                    projects: state.projects,
                    defaultIndex: state.defaultIndex,
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
          ),

          /// AreaSectionWidget
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.4,
            child: BlocBuilder<AreasBloc, AreasState>(
              builder: (context, state) {
                /// loading
                if (state is AreasLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      value: 15,
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  );
                }

                /// loaded
                if (state is AreasLoadedState) {
                  return AreaSectionWidget(
                    areas: state.areas,
                  );
                }

                /// error
                else if (state is AreasErrorState) {
                  return Center(
                    child: Text(
                        "Error: ${state.appError.appErrorType}, Message: ${state.appError.message}"),
                  );
                }

                return const Center(child: Text("Else To Show"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
