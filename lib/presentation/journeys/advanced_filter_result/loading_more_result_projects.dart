import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/logic/cubit/advanced_filter_projects/advanced_filter_projects_cubit.dart';
import '../../../common/constants/sizes.dart';

import '../../../domain/entities/app_error.dart';
import '../../logic/cubit/advanced_filter_projects/advanced_filter_projects_cubit.dart';
import '../../themes/theme_color.dart';
import '../../widgets/last_list_item.dart';
import '../../widgets/loading_widget.dart';

class LoadingMoreResultProjectsWidget extends StatelessWidget {
  final AdvancedFilterProjectsCubit advancedFilterProjectsCubit;

  const LoadingMoreResultProjectsWidget({
    Key? key,
    required this.advancedFilterProjectsCubit,
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
        child: BlocConsumer<AdvancedFilterProjectsCubit,
            AdvancedFilterProjectsState>(
          bloc: advancedFilterProjectsCubit,

          /// listener
          listener: (context, state) {
            //  show snackBar
            // if (state is ErrorWhileLoadingAdvancedFilterProjects) {
            //   if (state.appError.appErrorType == AppErrorType.api) {
            //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //       backgroundColor: AppColor.geeBung,
            //       behavior: SnackBarBehavior.floating,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(Sizes.dimen_16.w)),
            //       content: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: const [
            //           Icon(
            //             Icons.wifi_off_outlined,
            //             color: AppColor.white,
            //           ),
            //           Padding(
            //             padding: EdgeInsets.only(left: Sizes.dimen_4),
            //             child: Text(
            //               'Check Internet Connection',
            //             ),
            //           ),
            //         ],
            //       ),
            //     ));
            //   }
            // }
          },

          /// builder
          builder: (context, state) {
            //==> LastPageReached
            if (state is LastPageAdvancedFilterProjectsReached) {
              return const LastListItem();
            }

            //==> LoadMoreScreensError
            if (state is ErrorWhileLoadingMoreAdvancedFilterProjects) {
              return Column(
                children: [
                  const LoadingWidget(),
                  Text(
                    'No Internet Connection',
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
