import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/logic/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/selected_areas_widget.dart';

import '../../common/constants/sizes.dart';


import '../themes/theme_color.dart';
import 'MultiSelectionHelper.dart';

class ChooseFavoriteAreaWidget extends StatelessWidget {
  final List<AreaEntity> allAreas;
  final ChooseFavoriteAreaCubit chooseFavoriteAreaCubit;

  const ChooseFavoriteAreaWidget(
      {Key? key, required this.chooseFavoriteAreaCubit, required this.allAreas})
      : super(key: key);



  /// To open multi selection area
  void _openToSelectFavoriteArea(BuildContext context) {
    MultiSelectionHelper().showMultiSelect(
      context: context,
      allAreas: allAreas,
      chooseFavoriteAreaCubit: chooseFavoriteAreaCubit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseFavoriteAreaCubit, ChooseFavoriteAreaState>(
      bloc: chooseFavoriteAreaCubit,
      builder: (context, state) {
        return Column(
          children: [
            if (state.selectedAreas.isEmpty)
              Card(
                color: AppColor.extraTransparentGeeBung,
                child: InkWell(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Sizes.dimen_10.w)),
                  onTap: () => _openToSelectFavoriteArea(context),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TranslateConstants.chooseFavoriteAreas.t(context),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: AppColor.geeBung,
                                  fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.menu_open_outlined,
                          color: AppColor.geeBung,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            /// selected Areas
            /// Show selected areas if not empty
            if (state.selectedAreas.isNotEmpty)
              SelectedAreasWidget(
                  selectedAreas: state.selectedAreas,
                  onAddAreaPressed: () => _openToSelectFavoriteArea(context),
                  onRemoveAreaPressed: (value) {
                    if (value != null) {
                      chooseFavoriteAreaCubit.removeSelected(value);
                    }
                  }),
          ],
        );
      },
    );
  }
}
