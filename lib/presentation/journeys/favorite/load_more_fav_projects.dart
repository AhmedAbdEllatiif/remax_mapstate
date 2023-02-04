import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/logic/cubit/fav_projects/get_fav_projects_cubit.dart';
import '../../../common/constants/sizes.dart';

import '../../themes/theme_color.dart';
import '../../widgets/last_list_item.dart';
import '../../widgets/loading_widget.dart';

class LoadingMoreFavProjectsWidget extends StatelessWidget {
  final GetFavProjectsCubit getFavProjectsCubit;

  const LoadingMoreFavProjectsWidget({
    Key? key,
    required this.getFavProjectsCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Sizes.dimen_10,
          left: Sizes.dimen_10,
          right: Sizes.dimen_10,
          bottom: Sizes.dimen_30),
      child: Center(
        child: BlocBuilder<GetFavProjectsCubit, GetFavProjectsState>(
          bloc: getFavProjectsCubit,

          /// builder
          builder: (context, state) {
            //==> LastPageReached
            if (state is LastPageFavProjectsReached) {
              return const LastListItem();
            }

            //==> LoadMoreScreensError
            if (state is ErrorWhileLoadingMoreFavProjects) {
              return Column(
                children: [
                  const LoadingWidget(),
                  Text(
                    TranslateConstants.checkInternetConnection.t(context),
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: AppColor.white),
                  ),
                ],
              );
            }

            ///==> loading
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
