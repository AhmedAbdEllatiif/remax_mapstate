import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/presentation/logic/cubit/choose_favorite_area/choose_favorite_area_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_error_widget.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';
import 'package:remax_mapstate/presentation/widgets/selected_areas_widget.dart';

import '../../common/constants/sizes.dart';

import '../logic/cubit/areas/areas_cubit.dart';
import '../themes/theme_color.dart';
import 'MultiSelectionHelper.dart';

class ChooseFavoriteAreaWidget extends StatefulWidget {
  final ChooseFavoriteAreaCubit chooseFavoriteAreaCubit;

  const ChooseFavoriteAreaWidget(
      {Key? key, required this.chooseFavoriteAreaCubit})
      : super(key: key);

  @override
  State<ChooseFavoriteAreaWidget> createState() =>
      _ChooseFavoriteAreaWidgetState();
}

class _ChooseFavoriteAreaWidgetState extends State<ChooseFavoriteAreaWidget> {
  late final AreasCubit _areasCubit;

  @override
  void initState() {
    super.initState();
    _areasCubit = getItInstance<AreasCubit>();
    _fetchAllAreas();
  }

  @override
  void dispose() {
    _areasCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _areasCubit,
      child: BlocBuilder<AreasCubit, AreasState>(
        builder: (_, areasCubitState) {
          if (areasCubitState is LoadingAreas) {
            return const Center(child: LoadingWidget());
          }

          if (areasCubitState is ErrorWhileLoadingAreas) {
            return AppErrorWidget(
                appTypeError: areasCubitState.appError.appErrorType,
                onPressedRetry: () {
                  _fetchAllAreas();
                });
          }

          if (areasCubitState is AreasFetched) {
            return BlocBuilder<ChooseFavoriteAreaCubit,
                ChooseFavoriteAreaState>(
              bloc: widget.chooseFavoriteAreaCubit,
              builder: (context, state) {
                return Column(
                  children: [
                    if (state.selectedAreas.isEmpty)
                      Card(
                        color: AppColor.extraTransparentGeeBung,
                        child: InkWell(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.dimen_10.w)),
                          onTap: () => _openToSelectFavoriteArea(context,
                              areas: areasCubitState.areas),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  TranslateConstants.chooseFavoriteAreas
                                      .t(context),
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
                          onAddAreaPressed: () => _openToSelectFavoriteArea(
                              context,
                              areas: areasCubitState.areas),
                          onRemoveAreaPressed: (value) {
                            if (value != null) {
                              widget.chooseFavoriteAreaCubit
                                  .removeSelected(value);
                            }
                          }),
                  ],
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _fetchAllAreas() {
    _areasCubit.fetchAreas(
      context,
      limit: 100,
    );
  }

  /// To open multi selection area
  void _openToSelectFavoriteArea(BuildContext context,
      {required List<AreaEntity> areas}) {
    MultiSelectionHelper().showMultiSelect(
      context: context,
      allAreas: areas,
      chooseFavoriteAreaCubit: widget.chooseFavoriteAreaCubit,
    );
  }
}
