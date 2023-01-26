import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/functions/get_user_token.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/profile/get_authorized_user.dart';
import 'package:remax_mapstate/presentation/logic/cubit/update_default_user/update_default_user_cubit.dart';

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

  @override
  void initState() {
    super.initState();
    _updateDefaultUserCubit = getItInstance<UpdateDefaultUserCubit>();
  }

  @override
  void dispose() {
    _updateDefaultUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _updateDefaultUserCubit,
      child: BlocBuilder<UpdateDefaultUserCubit, UpdateDefaultUserState>(
        builder: (context, state) {
          if (state is NewFavoriteProjectAdded) {
            return IconButton(
              icon: const Icon(
                Icons.favorite,
                color: AppColor.geeBung,
              ),
              onPressed: _addOrRemoveFavProject,
            );
          }

          if (state is FavoriteProjectRemoved) {
            return IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: AppColor.geeBung,
              ),
              onPressed: _addOrRemoveFavProject,
            );
          }

          return IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: AppColor.geeBung,
            ),
            onPressed: _addOrRemoveFavProject,
          );
        },
      ),
    );
  }

  void _addOrRemoveFavProject() {
    final userToken = getUserToken(context);
    final userId = getAuthorizedUser(context).id;

    _updateDefaultUserCubit.updateFavoriteProjects(
      userId: userId,
      userToken: userToken,
      projectId: widget.projectId,
      addToFavorite: true,
    );
  }
}
