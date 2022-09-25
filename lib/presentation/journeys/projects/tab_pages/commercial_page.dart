import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/projects/project_card.dart';
import 'package:remax_mapstate/presentation/widgets/empty_list_widegt.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../logic/cubit/commercial_projects/commercial_projects_cubit.dart';

class CommercialPage extends StatefulWidget {
  const CommercialPage({Key? key}) : super(key: key);

  @override
  _CommercialPageState createState() => _CommercialPageState();
}

class _CommercialPageState extends State<CommercialPage>
    with AutomaticKeepAliveClientMixin<CommercialPage> {
  late final CommercialProjectsCubit commercialProjectsCubit;

  @override
  void initState() {
    super.initState();
    commercialProjectsCubit = getItInstance<CommercialProjectsCubit>();
    commercialProjectsCubit.loadCommercialProjects(0);
  }

  @override
  void dispose() {
    commercialProjectsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => commercialProjectsCubit,
      child: BlocBuilder<CommercialProjectsCubit, CommercialProjectsState>(
        builder: (context, state) {
          if (state is CommercialProjectsLoadingState) {
            return const LoadingWidget();
          }

          if (state is CommercialProjectsErrorState) {
            return Center(
              child: Text(
                  "Error: ${state.appError.appErrorType}, Message: ${state.appError.message}"),
            );
          }

          if (state is NoCommercialProjectsToShowState) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: const Center(
                child: EmptyListWidget(
                    text: "No Commercial projects in this area"),
              ),
            );
          }

          if (state is CommercialProjectsLoadedState) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.projects.length,
                itemBuilder: (context, index) => ProjectCardWidget(
                      projectEntity: state.projects[index],
                      testingIndex: index,
                    ));
          }

          return const Center(
            /// TODO Remove this
            child: Text("Nothing to Show"),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
