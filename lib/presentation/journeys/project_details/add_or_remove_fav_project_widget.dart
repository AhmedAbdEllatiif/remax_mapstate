import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/functions/get_user_token.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/common/functions/get_authorized_user.dart';
import 'package:remax_mapstate/presentation/logic/cubit/update_default_user/update_default_user_cubit.dart';

import '../../logic/cubit/check_current_project_favorite/check_current_favorite_project_cubit.dart';
import '../../themes/theme_color.dart';

class AddOrRemoveFavProjectWidget extends StatefulWidget {
  final String projectId;

  const AddOrRemoveFavProjectWidget({Key? key, required this.projectId})
      : super(key: key);

  @override
  State<AddOrRemoveFavProjectWidget> createState() =>
      _AddOrRemoveFavProjectWidgetState();
}

class _AddOrRemoveFavProjectWidgetState
    extends State<AddOrRemoveFavProjectWidget> {
  late final UpdateDefaultUserCubit _updateDefaultUserCubit;
  late final CheckCurrentFavoriteProjectCubit _checkFavoriteCubit;

  @override
  void initState() {
    super.initState();
    _updateDefaultUserCubit = getItInstance<UpdateDefaultUserCubit>();
    _checkFavoriteCubit = getItInstance<CheckCurrentFavoriteProjectCubit>();
    _checkFavoriteProject();
  }

  @override
  void dispose() {
    _updateDefaultUserCubit.close();
    _checkFavoriteCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _updateDefaultUserCubit),
        BlocProvider(create: (context) => _checkFavoriteCubit),
      ],
      child: BlocBuilder<UpdateDefaultUserCubit, UpdateDefaultUserState>(
        builder: (context, state) {
          if (state is NewFavoriteProjectAdded) {
            return IconButton(
              icon: const Icon(
                Icons.favorite,
                color: AppColor.geeBung,
              ),
              onPressed: () => _addOrRemoveFavProject(false),
            );
          }

          if (state is FavoriteProjectRemoved) {
            return IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: AppColor.geeBung,
              ),
              onPressed: () => _addOrRemoveFavProject(true),
            );
          }

          return BlocBuilder<CheckCurrentFavoriteProjectCubit,
              CheckCurrentFavoriteProjectState>(
            builder: (context, state) {
              if (state is CurrentProjectFavOrNotResult) {
                return IconButton(
                  icon: Icon(
                    state.isFavoriteProject
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: AppColor.geeBung,
                  ),
                  onPressed: () =>
                      _addOrRemoveFavProject(!state.isFavoriteProject),
                );
              }

              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  void _checkFavoriteProject() {
    final userToken = getUserToken(context);
    final userId = getAuthorizedUser(context).id;
    _checkFavoriteCubit.checkCurrentProjectIsFavorite(
      userToken: userToken,
      userId: userId,
      projectId: widget.projectId,
    );
  }

  void _addOrRemoveFavProject(bool addToFavorite) {
    final userToken = getUserToken(context);
    final userId = getAuthorizedUser(context).id;

    _updateDefaultUserCubit.updateFavoriteProjects(
      userId: userId,
      userToken: userToken,
      projectId: widget.projectId,
      addToFavorite: addToFavorite,
    );
  }
}
