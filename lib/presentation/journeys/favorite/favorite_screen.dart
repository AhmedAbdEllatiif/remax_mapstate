import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/widgets/empty_list_widegt.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';

import '../../logic/bloc/favorite_projects/favorite_projects_bloc.dart';

class FavoriteScreen extends StatefulWidget {


  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  late FavoriteProjectsBloc favoriteProjectsBloc;


  @override
  void initState() {
    super.initState();
    favoriteProjectsBloc = getItInstance<FavoriteProjectsBloc>();
    favoriteProjectsBloc.add(LoadFavoriteProjectsEvent());
  }

  @override
  void dispose() {
    favoriteProjectsBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => favoriteProjectsBloc,

      child: BlocBuilder<FavoriteProjectsBloc, FavoriteProjectsState>(
        builder: (context, state) {

          if(state is FavoriteProjectsLoading){
            return const Center(child: LoadingWidget());
          }

          if(state is FavoriteProjectsNoProjectsToShow){
            return Center(child: EmptyListWidget(text: TranslateConstants.noFavProjectsToShow.t(context),));
          }
          if (state is FavoriteProjectsLoadedState) {
            return Center(child: Text("StateLoaded: ${state.projects}"),);
          }

          if (state is FavoriteProjectsErrorState) {
            return Center(child: Text(
                "Error: ${state.appError.appErrorType} , Message: ${state
                    .appError.message}"),);
          }

          return Center(child: Text("State: $state"),);
        },
      ),
    );
  }
}











