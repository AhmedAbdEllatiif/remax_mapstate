import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:remax_mapstate/common/constants/app_utils.dart';
import 'package:remax_mapstate/common/constants/translate_constatns.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/common/extensions/string_extensions.dart';
import 'package:remax_mapstate/common/screen_utils/screen_util.dart';
import 'package:remax_mapstate/data/models/filter_model.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/logic/cubit/advanced_filter_projects/advanced_filter_projects_cubit.dart';
import 'package:remax_mapstate/presentation/logic/cubit/get_filter_data/get_filter_data_cubit.dart';
import 'package:remax_mapstate/presentation/themes/theme_color.dart';
import 'package:remax_mapstate/presentation/widgets/app_drop_down_field.dart';
import 'package:remax_mapstate/presentation/widgets/stack_with_full_background.dart';
import 'package:remax_mapstate/router/route_hepler.dart';

import '../../../common/constants/sizes.dart';
import '../../../domain/entities/project_entity.dart';
import '../../arguments/advanced_filter_result_args.dart';
import '../../logic/cubit/advanced_filter_builder/advanced_filter_builder_cubit.dart';
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
  late final GetFilterDataCubit _getFilterDataCubit;
  late final AdvancedFilterProjectsCubit _advancedFilterProjectsCubit;
  late final AdvancedFilterBuilderCubit _advancedFilterBuilderCubit;

  RangeValues _priceRangeValues = const RangeValues(100000, 10000000);
  RangeValues _areaRangeValues = const RangeValues(0, 2000);
  var f = NumberFormat("###.0#", "en_US");
  var currency = NumberFormat.currency(
    decimalDigits: 0,
    locale: 'en_US',
    symbol: "",
  );

  var decimalPattern = NumberFormat.decimalPattern('en_US');

  @override
  void initState() {
    super.initState();
    _getFilterDataCubit = getItInstance<GetFilterDataCubit>();
    _advancedFilterProjectsCubit = getItInstance<AdvancedFilterProjectsCubit>();
    _advancedFilterBuilderCubit = getItInstance<AdvancedFilterBuilderCubit>();
    _fetchFilterData();
  }

  @override
  void dispose() {
    _getFilterDataCubit.close();
    _advancedFilterProjectsCubit.close();
    _advancedFilterBuilderCubit.close();
    super.dispose();
  }

  String projectType = "";
  String city = "";
  String finishingType = "";
  String unitType = "";
  String deliveryDate = "";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _getFilterDataCubit),
        BlocProvider(create: (context) => _advancedFilterProjectsCubit),
        BlocProvider(create: (context) => _advancedFilterBuilderCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          /*BlocListener<AdvancedFilterProjectsCubit,
              AdvancedFilterProjectsState>(listener: (context, state) {
            if (state is AdvancedFilterProjectsFetched) {
              _navigateToAdvancedFilterResultScreen(projects: state.projects);
            }

            if (state is LastPageAdvancedFilterProjectsReached) {
              _navigateToAdvancedFilterResultScreen(projects: state.projects);
            }

            if (state is EmptyAdvancedFilterProjects) {
              _navigateToAdvancedFilterResultScreen(projects: []);
            }
          }),*/
          BlocListener<AdvancedFilterBuilderCubit, AdvancedFilterBuilderState>(
              listener: (context, state) {
            if (state is FiltersToAdd) {
              _navigateToAdvancedFilterResultScreen(filters: state.filters);
            }
          })
        ],
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
                              hintText: "Choose Project Type",
                              itemsList: [
                                TranslateConstants.commercial.t(context),
                                TranslateConstants.residential.t(context)
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  projectType = value;
                                }
                              }),

                          /// space
                          SizedBox(height: Sizes.dimen_5.h),

                          /// city
                          AppDropDownField(
                              hintText: "Choose City",
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
                              hintText: "Choose Finishing Type",
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
                              hintText: "Choose Unit Type",
                              itemsList: state.filterDataEntity.unitTypes,
                              onChanged: (value) {
                                if (value != null) {
                                  unitType = value;
                                }
                              }),

                          /// space
                          SizedBox(height: Sizes.dimen_5.h),

                          /// city
                          AppDropDownField(
                              hintText: "Choose Delivery Date",
                              itemsList: const [
                                "2022",
                                "2023",
                                "2024",
                                "2025",
                                "2026",
                                "2027",
                                "2028",
                                "2029",
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  deliveryDate = value;
                                }
                              }),

                          /// space
                          SizedBox(height: Sizes.dimen_5.h),

                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.black,
                              borderRadius: BorderRadius.circular(
                                  AppUtils.cornerRadius.w),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: Sizes.dimen_5.h,
                              horizontal: Sizes.dimen_10.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price Range (EGP)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColor.white),
                                ),
                                RangeSlider(
                                  values: _priceRangeValues,
                                  min: 100000,
                                  max: 10000000,
                                  divisions: 20,
                                  inactiveColor:
                                      AppColor.geeBung.withOpacity(0.5),
                                  activeColor: AppColor.geeBung,
                                  labels: RangeLabels(
                                    _priceRangeValues.start.round().toString(),
                                    _priceRangeValues.end.round().toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      _priceRangeValues = values;
                                    });
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: Sizes.dimen_3.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.fadeBlack,
                                            borderRadius: BorderRadius.circular(
                                                AppUtils.cornerRadius.w),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Text(currency.format(
                                              _priceRangeValues.start))),
                                      Text(
                                        "To",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: AppColor.white,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.fadeBlack,
                                            borderRadius: BorderRadius.circular(
                                                AppUtils.cornerRadius.w),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Text(currency
                                              .format(_priceRangeValues.end))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          /// space
                          SizedBox(height: Sizes.dimen_5.h),

                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.black,
                              borderRadius: BorderRadius.circular(
                                  AppUtils.cornerRadius.w),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: Sizes.dimen_5.h,
                              horizontal: Sizes.dimen_10.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Area Range (m)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColor.white),
                                ),
                                RangeSlider(
                                  values: _areaRangeValues,
                                  max: 2000,
                                  min: 0,
                                  divisions: 1000,
                                  inactiveColor:
                                      AppColor.geeBung.withOpacity(0.5),
                                  activeColor: AppColor.geeBung,
                                  labels: RangeLabels(
                                    _areaRangeValues.start.round().toString(),
                                    _areaRangeValues.end.round().toString(),
                                  ),
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      _areaRangeValues = values;
                                    });
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: Sizes.dimen_3.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.fadeBlack,
                                            borderRadius: BorderRadius.circular(
                                                AppUtils.cornerRadius.w),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Text(decimalPattern
                                              .format(_areaRangeValues.start))),
                                      Text(
                                        "To",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: AppColor.white,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.fadeBlack,
                                            borderRadius: BorderRadius.circular(
                                                AppUtils.cornerRadius.w),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Text(decimalPattern
                                              .format(_areaRangeValues.end))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<AdvancedFilterProjectsCubit,
                        AdvancedFilterProjectsState>(
                      builder: (context, state) {
                        return state is LoadingAdvancedFilterProjects
                            ? const Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                left: 0.0,
                                child: LoadingWidget())
                            : Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                left: 0.0,
                                child: InkWell(
                                  onTap: () {
                                    _searchProjects();
                                  },
                                  splashColor: AppColor.fadeBlack,
                                  child: Container(
                                    height: ScreenUtil.screenHeight * 0.08,
                                    decoration: BoxDecoration(
                                        color: AppColor.geeBung,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                Sizes.dimen_20.w),
                                            topLeft: Radius.circular(
                                                Sizes.dimen_20.w))),
                                    child: Center(
                                        child: Text(
                                      "Show Result",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    )),
                                  ),
                                ),
                              );
                      },
                    )
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

  void _fetchFilterData() {
    // init userToken
    // final userToken = context.read<UserTokenCubit>().state.userToken;

    _getFilterDataCubit.fetchFilterData(context, userToken: "");
  }

  void _searchProjects() {
    log("\n..................area: ${_areaRangeValues.start}, "
        "area: ${_areaRangeValues.end}\n..................");

    _advancedFilterBuilderCubit.reset();


    _advancedFilterBuilderCubit.addFilters(
      context,
      type: projectType,
      city: city,
      finishingType: finishingType,
      unitType: unitType,
      deliveryDate: deliveryDate,
      priceFrom: _priceRangeValues.start,
      priceTo:  _priceRangeValues.end,
      areaFrom: _areaRangeValues.start,
      areaTo: _areaRangeValues.end,
    );
  }

  void _navigateToAdvancedFilterResultScreen(
      {required List<FilterModel> filters}) {
    RouteHelper().advancedFilterResultScreen(context,
        advancedFilterResultArgs: AdvancedFilterResultArgs(
          filters: filters,
        ));
  }
}
