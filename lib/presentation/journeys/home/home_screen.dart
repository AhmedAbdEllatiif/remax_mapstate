import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/home/area/area_section.dart';
import 'package:remax_mapstate/presentation/journeys/home/top_projects/top_projects_widget.dart';
import 'package:remax_mapstate/presentation/widgets/loading_animation_widget.dart';


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
    _areasCubit.fetchAreas();

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


    return MultiBlocProvider(
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
              child: LoadingAnimationWidget(),
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
                    projectStausList:  state.projectStatus,
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
