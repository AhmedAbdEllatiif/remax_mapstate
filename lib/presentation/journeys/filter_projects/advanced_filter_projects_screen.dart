import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/constants/drop_down_lists.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/enums/range_format.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/data/models/filter_model.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/logic/cubit/get_filter_data/get_filter_data_cubit.dart';
import 'package:remax_mapstate/presentation/widgets/app_drop_down_field.dart';
import 'package:remax_mapstate/presentation/widgets/bottom_button.dart';
import 'package:remax_mapstate/presentation/widgets/range_slider_widget.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../../common/constants/sizes.dart';
import '../../arguments/advanced_filter_result_args.dart';
import '../../logic/cubit/search_filter_builder/search_filter_builder_cubit.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/loading_widget.dart';

class AdvancedFilterProjectsScreen extends StatefulWidget {
  const AdvancedFilterProjectsScreen({Key? key}) : super(key: key);

  @override
  State<AdvancedFilterProjectsScreen> createState() =>
      _AdvancedFilterProjectsScreenState();
}

class _AdvancedFilterProjectsScreenState
    extends State<AdvancedFilterProjectsScreen> {
  /// GetFilterDataCubit
  late final GetFilterDataCubit _getFilterDataCubit;

  /// SearchFilterBuilderCubit
  late final SearchFilterBuilderCubit _filterBuilder;

  @override
  void initState() {
    super.initState();

    //==> init GetFilterDataCubit
    _getFilterDataCubit = getItInstance<GetFilterDataCubit>();

    //==> init SearchFilterBuilderCubit
    _filterBuilder = getItInstance<SearchFilterBuilderCubit>();
    _fetchFilterData();
  }

  @override
  void dispose() {
    _getFilterDataCubit.close();
    _filterBuilder.close();
    super.dispose();
  }

  /// filters
  String projectType = "";
  String city = "";
  String finishingType = "";
  String unitType = "";
  String deliveryDate = "";
  double startPrice = 100000;
  double endPrice = 10000000;
  double startArea = 0;
  double endArea = 2000;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getFilterDataCubit),
        BlocProvider(create: (context) => _filterBuilder),
      ],
      child: BlocListener<SearchFilterBuilderCubit, SearchFilterBuilderState>(
        listener: (context, state) {
          /// filters built
          if (state is FiltersBuiltSuccessfully) {
            _navigateToAdvancedFilterResultScreen(filters: state.filters);
          }
        },

        /// scaffold
        child: StackScaffoldWithFullBackground(
          /// appBar
          appBarTitle: Text(
            TranslateConstants.advancedSearch.t(context),
          ),

          /// body
          body: BlocBuilder<GetFilterDataCubit, GetFilterDataState>(
            builder: (context, state) {
              //==> loading
              if (state is LoadingGetFilterData) {
                return const Center(
                  child: LoadingWidget(),
                );
              }

              //==> error
              if (state is ErrorWhileGettingFilterData) {
                return Center(
                  child: AppErrorWidget(
                    appTypeError: state.appError.appErrorType,
                    onPressedRetry: () {
                      _fetchFilterData;
                    },
                  ),
                );
              }

              //==> fetched
              if (state is FilterDataFetched) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: AppUtils.screenHorizontalPadding.w,
                          vertical: Sizes.dimen_10.h),
                      child: Column(
                        children: [
                          /// project type
                          AppDropDownField(
                              hintText: TranslateConstants.chooseProjectType.t(context),
                              itemsList: [
                                TranslateConstants.commercial.t(context),
                                TranslateConstants.residential.t(context)
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  /// TODO
                                  /// TranslateConstants.commercial.toLowerCase
                                  /// TranslateConstants.residential.toLowerCase
                                  projectType = value;
                                }
                              }),

                          /// space
                          SizedBox(height: Sizes.dimen_5.h),

                          /// city
                          AppDropDownField(
                              hintText: TranslateConstants.chooseCity.t(context),
                              itemsList: state.filterDataEntity.cities,
                              onChanged: (value) {
                                if (value != null) {
                                  city = value;
                                }
                              }),

                          /// space
                          SizedBox(height: Sizes.dimen_5.h),

                          /// finishingTypes
                          AppDropDownField(
                              hintText: TranslateConstants.chooseFinishingType.t(context),
                              itemsList: state.filterDataEntity.finishingTypes,
                              onChanged: (value) {
                                if (value != null) {
                                  finishingType = value;
                                }
                              }),

                          /// space
                          SizedBox(height: Sizes.dimen_5.h),

                          /// unitType
                          AppDropDownField(
                              hintText: TranslateConstants.chooseUnitType.t(context),
                              itemsList: state.filterDataEntity.unitTypes,
                              onChanged: (value) {
                                if (value != null) {
                                  unitType = value;
                                }
                              }),

                          /// space
                          SizedBox(height: Sizes.dimen_5.h),

                          /// delivery date
                          AppDropDownField(
                              hintText: TranslateConstants.chooseDeliveryDate.t(context),
                              itemsList: yearsList(countOfYears: 8),
                              onChanged: (value) {
                                if (value != null) {
                                  deliveryDate = value;
                                }
                              }),

                          /// space
                          SizedBox(height: Sizes.dimen_5.h),

                          /// price slider
                          RangeSliderWidget(
                              title: TranslateConstants.priceRange.t(context),
                              start: startPrice,
                              end: endPrice,
                              divisions: 20,
                              rangeFormat: RangeFormat.decimal,
                              onRangeChanged: (RangeValues values) {
                                startPrice = values.start;
                                endPrice = values.end;
                              }),

                          /// space
                          SizedBox(height: Sizes.dimen_5.h),

                          /// area slider
                          RangeSliderWidget(
                              title: TranslateConstants.areaRange.t(context),
                              start: startArea,
                              end: endArea,
                              divisions: 1000,
                              rangeFormat: RangeFormat.decimal,
                              onRangeChanged: (RangeValues values) {
                                startArea = values.start;
                                endArea = values.end;
                              }),
                        ],
                      ),
                    ),

                    /// show result button
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      left: 0.0,
                      child: BottomButtonWidget(
                        text: "Show Result",
                        onPressed: () => _buildFilters(),
                      ),
                    ),
                  ],
                );
              }

              //==> other
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  /// to fetch filters data
  void _fetchFilterData() {
    // init userToken
    // final userToken = context.read<UserTokenCubit>().state.userToken;
    _getFilterDataCubit.fetchFilterData(context, userToken: "");
  }

  /// to build filters
  void _buildFilters() {
    _filterBuilder.buildFilters(
      context,
      type: projectType,
      city: city,
      finishingType: finishingType,
      unitType: unitType,
      deliveryDate: deliveryDate,
      priceFrom: startPrice,
      priceTo: endPrice,
      areaFrom: startArea,
      areaTo: endArea,
    );
  }

  /// to navigate to result of search screen
  void _navigateToAdvancedFilterResultScreen(
      {required List<FilterModel> filters}) {
    RouteHelper().advancedFilterResultScreen(context,
        advancedFilterResultArgs: AdvancedFilterResultArgs(
          filters: filters,
        ));
  }
}
