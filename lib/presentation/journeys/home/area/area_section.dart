import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/presentation/journeys/home/area/area_grid_view.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../../logic/cubit/areas/areas_cubit.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/see_all_widget.dart';
import 'area_card.dart';

class AreaSectionWidget extends StatelessWidget {
  //final List<AreaEntity> areas_by_status;

  const AreaSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AreasCubit, AreasState>(
      builder: (_, state) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.dimen_4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// see all widget
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                child: SeeAllWidget(
                  title: TranslateConstants.findByArea.t(context),
                  onSeeAllPressed: () => _navigateToAllAreas(context),
                ),
              ),

              /// loading
              if (state is LoadingAreas)
                const Expanded(
                  child: Center(child: LoadingWidget()),
                ),

              /// loaded
              if (state is AreasFetched)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Sizes.dimen_8.h, horizontal: Sizes.dimen_8.w),
                    child: AreaGridView(areas: state.areas),
                  ),
                ),

              /// error
              if (state is ErrorWhileLoadingAreas)
                Expanded(
                  child: Center(
                    child: AppErrorWidget(
                      appTypeError: state.appError.appErrorType,
                      onPressedRetry: () {
                        context
                            .read<AreasCubit>()
                            .fetchAreas(context, limit: 6);
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// To navigate to all areas_by_status
  void _navigateToAllAreas(BuildContext context) =>
      RouteHelper().allAreasScreen(context);
}
