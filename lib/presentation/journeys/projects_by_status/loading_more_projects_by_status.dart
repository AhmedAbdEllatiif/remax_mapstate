import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/presentation/logic/cubit/projects_by_status/projects_by_status_cubit.dart';
import '../../../common/constants/sizes.dart';

import '../../../domain/entities/app_error.dart';
import '../../themes/theme_color.dart';
import '../../widgets/last_list_item.dart';
import '../../widgets/loading_widget.dart';

class LoadingMoreProjectsByStatusWidget extends StatelessWidget {
  final ProjectsByStatusCubit projectsByStatusCubit;

  const LoadingMoreProjectsByStatusWidget({
    Key? key,
    required this.projectsByStatusCubit,
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
        child: BlocConsumer<ProjectsByStatusCubit, ProjectsByStatusState>(

          /// listener
          listener: (context, state) {
            //  show snackBar
            if (state is ErrorWhileLoadingProjectsByStatus) {
              if (state.appError.appErrorType == AppErrorType.api) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColor.geeBung,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Sizes.dimen_16.w)),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.wifi_off_outlined,
                        color: AppColor.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Sizes.dimen_4),
                        child: Text(
                          'Check Internet Connection',
                        ),
                      ),
                    ],
                  ),
                ));
              }
            }
          },

          /// builder
          builder: (context, state) {
            //==> LastPageReached
            if (state is LastPageProjectsByStatusReached) {
              return const LastListItem();
            }

            //==> LoadMoreScreensError
            if (state is LoadingProjectsByStatus) {
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
            return SizedBox(height: Sizes.dimen_40.h,child: const LoadingWidget());
          },
        ),
      ),
    );
  }
}
