import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/bloc/projects/fetch_projects_bloc.dart';
import 'package:remax_mapstate/presentation/cubit/residential_projects/residential_projects_cubit.dart';
import 'package:remax_mapstate/presentation/journeys/area_projects/unit_types_list_widget.dart';

import 'package:remax_mapstate/presentation/widgets/empty_list_widegt.dart';
import 'package:remax_mapstate/presentation/widgets/loading_animation_widget.dart';

import '../project_card.dart';

class ResidentialPage extends StatefulWidget {
  const ResidentialPage({Key? key}) : super(key: key);

  @override
  _ResidentialPageState createState() => _ResidentialPageState();
}

class _ResidentialPageState extends State<ResidentialPage>
    with AutomaticKeepAliveClientMixin<ResidentialPage> {


  late final ResidentialProjectsCubit residentialProjectsCubit;

  @override
  void initState() {
    residentialProjectsCubit = getItInstance<ResidentialProjectsCubit>();
    residentialProjectsCubit.loadResidentialProjects(0);
    super.initState();
  }

  @override
  void dispose() {
    residentialProjectsCubit.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => residentialProjectsCubit,
      child: BlocBuilder<ResidentialProjectsCubit, ResidentialProjectsState>(
        builder: (context, state) {
          if (state is ResidentialProjectsLoadingState) {
            return const LoadingAnimationWidget();
          }

          if (state is ResidentialProjectsErrorState) {
            return Center(child: Text(
                "Error: ${state.appError.appErrorType}, Message: ${state
                    .appError.message}"),);
          }

          if (state is NoResidentialProjectsToShowState) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: const Center(
                child:  EmptyListWidget(
                    text: "No Residential projects in this area"),
              ),
            );
          }

          if (state is ResidentialProjectsLoadedState) {
            return Padding(
              padding:  EdgeInsets.all(Sizes.dimen_30.w),
              child: UnitTypeListWidget(),
            );
           /* return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.projects.length,
                itemBuilder: (context, index) =>
                    ProjectCardWidget(
                      projectEntity: state.projects[index],
                    ));*/
          }

          return const Center(
            child: Text("Nothing to Show"),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
