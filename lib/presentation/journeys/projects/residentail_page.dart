import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/presentation/bloc/top_projects/top_projects_bloc.dart';
import 'package:remax_mapstate/presentation/journeys/projects/project_card.dart';

class ResidentialPage extends StatefulWidget {
  const ResidentialPage({Key? key}) : super(key: key);

  @override
  _ResidentialPageState createState() => _ResidentialPageState();
}

class _ResidentialPageState extends State<ResidentialPage> with AutomaticKeepAliveClientMixin<ResidentialPage> {
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

        return Center(
          child: const Text("Nothing to Show"),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
