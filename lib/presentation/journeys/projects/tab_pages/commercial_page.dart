import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/common/extensions/size_extensions.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/presentation/journeys/projects/project_card.dart';
import 'package:remax_mapstate/presentation/widgets/empty_list_widegt.dart';
import 'package:remax_mapstate/presentation/widgets/loading_widget.dart';

import '../../../../common/constants/sizes.dart';
import '../../../logic/cubit/commercial_projects/commercial_projects_cubit.dart';
import '../../../logic/cubit/unitType_names/unit_type_names_cubit.dart';
import '../../area_unit_types/unit_types_list_widget.dart';

class CommercialPage extends StatefulWidget {
  const CommercialPage({Key? key}) : super(key: key);

  @override
  _CommercialPageState createState() => _CommercialPageState();
}

class _CommercialPageState extends State<CommercialPage>
    with AutomaticKeepAliveClientMixin<CommercialPage> {
  late final UnitTypeNamesCubit unitTypeNamesCubit;

  @override
  void initState() {
    unitTypeNamesCubit = getItInstance<UnitTypeNamesCubit>();

    unitTypeNamesCubit.loadUnitTypes(
      context,
      isCommercial: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    unitTypeNamesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => unitTypeNamesCubit,
      child: BlocBuilder<UnitTypeNamesCubit, UnitTypeNamesState>(
        builder: (context, state) {
          /// loading
          if (state is LoadingUnitTypeNames) {
            return const LoadingWidget();
          }

          /// Error
          if (state is ErrorWhileLoadingUnitTypeNames) {
            return Center(
              child: Text(
                  "Error: ${state.appError.appErrorType}, Message: ${state.appError.message}"),
            );
          }


          ///No UnitTypes to show
          if (state is EmptyUnitTypeNames) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: const Center(
                child: EmptyListWidget(text: "No unit types to show",),
              ),
            );
          }

          /// UnitTypes Loaded
          if (state is UnitTypesLoadedState) {
            return Padding(
              padding: EdgeInsets.all(Sizes.dimen_30.w),
              child: UnitTypeListWidget(
                unitTypeList: state.unitTypes,
              ),
            );
          }

          return const Center(
            child: Text("Nothing to Show"),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
