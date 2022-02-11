import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/top_projects/top_projects_bloc.dart';
import 'package:remax_mapstate/presentation/journeys/projects/project_card.dart';

class CommercialPage extends StatefulWidget {
  const CommercialPage({Key? key}) : super(key: key);

  @override
  _CommercialPageState createState() => _CommercialPageState();
}

class _CommercialPageState extends State<CommercialPage> with AutomaticKeepAliveClientMixin<CommercialPage> {
  @override
  Widget build(BuildContext context) {
    return     BlocBuilder<TopProjectsBloc, TopProjectsState>(
      builder: (context, state) {
        if (state is TopProjectsLoadedState) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.projects.length,
              itemBuilder: (context, index) => ProjectCardWidget(
                projectEntity: state.projects[index],
              ));
        }

        return const Center(
          child: const Text("Nothing to Show"),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
