import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/sizes.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/presentation/journeys/home/area/area_grid_view.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/presentation/themes/theme_text.dart';

import '../../../logic/cubit/areas/areas_cubit.dart';

class AreaSectionWidget extends StatelessWidget {
  //final List<AreaEntity> areas;

  const AreaSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AreasCubit, AreasState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: Sizes.dimen_4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TranslateConstants.findByArea.t(context),
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: AppColor.geeBung,
                        fontWeight: FontWeight.w600
                      ),
                    ),

                    Text(
                      TranslateConstants.seeAll.t(context),
                      style: Theme.of(context).textTheme.whiteSubtitle1.copyWith(
                          color: AppColor.geeBung,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),



              /// loading
              if (state is LoadingAreas)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      value: 15,
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  ),
                ),

              /// loaded
              if (state is AreasFetched)
                Expanded(child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: Sizes.dimen_8.h,horizontal: Sizes.dimen_8.w),
                  child: AreaGridView(areas: state.areas),
                )),

              if (state is ErrorWhileLoadingAreas)
                Expanded(
                  child: Center(
                    child: Text(
                        "Error: ${state.appError.appErrorType}, Message: ${state.appError.message}"),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
