import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/bloc/project_backdrop/project_backdrop_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/top_projects/top_projects_bloc.dart';
import 'package:remax_mapstate/presentation/journeys/home/top_projects/top_projects_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TopProjectsBloc _topProjectsBloc;
  late ProjectBackdropBloc _backdropBloc;


  @override
  void initState() {
    super.initState();
    _topProjectsBloc = getItInstance<TopProjectsBloc>();
    _topProjectsBloc.add(const LoadTopProjectsEvent());

    _backdropBloc = _topProjectsBloc.backdropBloc;
  }

  @override
  void dispose() {
    _topProjectsBloc.close();
    _backdropBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _topProjectsBloc),
        BlocProvider(create: (context) => _backdropBloc),
      ],
      child: BlocBuilder<TopProjectsBloc, TopProjectsState>(
        builder: (context, state) {
          print("Home State ==> $state");

          if (state is TopProjectsInitial) {
            return const Center(child: Text("Top Projects Initial"));
          }

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


              ],
            );
          }

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
