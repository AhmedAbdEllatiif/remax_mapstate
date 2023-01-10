import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/widgets/project_item_widget.dart';
import 'package:remax_mapstate/presentation/widgets/empty_list_widegt.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../data/models/filter_model.dart';
import '../../../../router/route_hepler.dart';
import '../../../arguments/advanced_filter_result_args.dart';
import '../../../logic/cubit/commercial_projects/commercial_projects_cubit.dart';
import '../../../logic/cubit/search_filter_builder/search_filter_builder_cubit.dart';
import '../../../logic/cubit/unitType_names/unit_type_names_cubit.dart';
import '../../../widgets/app_error_widget.dart';
import '../../area_unit_types/grid_of_unit_types_widget.dart';

class CommercialUnitTypesPage extends StatefulWidget {
  final String cityName;

  const CommercialUnitTypesPage({Key? key, required this.cityName})
      : super(key: key);

  @override
  _CommercialUnitTypesPageState createState() =>
      _CommercialUnitTypesPageState();
}

class _CommercialUnitTypesPageState extends State<CommercialUnitTypesPage>
    with AutomaticKeepAliveClientMixin<CommercialUnitTypesPage> {
  /// SearchFilterBuilderCubit
  late final SearchFilterBuilderCubit _filterBuilderCubit;

  // UnitTypeNamesCubit
  late final UnitTypeNamesCubit unitTypeNamesCubit;

  @override
  void initState() {
    //==> init SearchFilterBuilderCubit
    _filterBuilderCubit = getItInstance<SearchFilterBuilderCubit>();

    // init UnitTypeNamesCubit
    unitTypeNamesCubit = getItInstance<UnitTypeNamesCubit>();

    // fetch unit type names
    _fetchUnitTypeNames();

    super.initState();
  }

  @override
  void dispose() {
    unitTypeNamesCubit.close();
    _filterBuilderCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => unitTypeNamesCubit),
        BlocProvider(create: (context) => _filterBuilderCubit),
      ],
      child: BlocListener<SearchFilterBuilderCubit, SearchFilterBuilderState>(
        listener: (context, state) {
          /// filters built
          if (state is FiltersBuiltSuccessfully) {
            _navigateToAdvancedFilterResultScreen(filters: state.filters);
          }
        },
        child: BlocBuilder<UnitTypeNamesCubit, UnitTypeNamesState>(
          builder: (context, state) {
            /// loading
            if (state is LoadingUnitTypeNames) {
              return const LoadingWidget();
            }

            /// Error
            if (state is ErrorWhileLoadingUnitTypeNames) {
              return Center(
                child: AppErrorWidget(
                  appTypeError: state.appError.appErrorType,
                  onPressedRetry: () => _fetchUnitTypeNames(),
                ),
              );
            }

            ///No UnitTypes to show
            if (state is EmptyUnitTypeNames) {
              return Container(
                margin: const EdgeInsets.all(10),
                child: const Center(
                  child: EmptyListWidget(
                    text: "No unit types to show",
                  ),
                ),
              );
            }

            /// UnitTypes Loaded
            if (state is UnitTypesLoadedState) {
              return Padding(
                padding: EdgeInsets.all(Sizes.dimen_30.w),
                child: UnitTypeListWidget(
                  unitTypeList: state.unitTypes,
                  onUnitTypePressed: (unitTypeName) {
                    _buildFilters(unitTypeName: unitTypeName);
                  },
                ),
              );
            }

            return const Center(
              child: Text("Nothing to Show"),
            );
          },
        ),
      ),
    );
  }

  /// To fetch unit types names
  void _fetchUnitTypeNames() => unitTypeNamesCubit.loadUnitTypes(
        context,
        isCommercial: true,
      );

  /// to build filters
  void _buildFilters({required String unitTypeName}) {
    _filterBuilderCubit.buildByArea(
      context,
      type: "commercial",
      city: widget.cityName,
      unitType: unitTypeName,
    );
  }

  /// to navigate to result of search screen
  void _navigateToAdvancedFilterResultScreen({
    required List<FilterModel> filters,
  }) {
    RouteHelper().advancedFilterResultScreen(context,
        advancedFilterResultArgs: AdvancedFilterResultArgs(
          filters: filters,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
