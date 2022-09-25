import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remax_mapstate/data/models/filter_model.dart';
import 'package:remax_mapstate/data/models/page_info.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/area_projects_param.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/entities/unit_type_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_residential_projects.dart';
import 'package:remax_mapstate/domain/use_cases/get_unit_types_by_area.dart';

import '../../../../common/enums/app_language.dart';
import '../../../../data/params/fetch_list_params.dart';
import '../language/language_cubit.dart';

part 'unit_type_name_state.dart';

class UnitTypeNamesCubit extends Cubit<UnitTypeNamesState> {
  final GetResidentialProjectsCase residentialProjectsCase;
  final GetUnitTypeNamesCase getUnitTypesByAreaCase;

  UnitTypeNamesCubit(
      {required this.getUnitTypesByAreaCase,
      required this.residentialProjectsCase})
      : super(ResidentialInitial());

  void _emitIfNotClosed(UnitTypeNamesState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  /// loadUnitTypes
  void loadUnitTypes(BuildContext context, {required bool isCommercial}) async {
    emit(LoadingUnitTypeNames());

    // init current language
    final languageCode = context.read<LanguageCubit>().state.languageCode;
    final appLanguage = languageCode == "en" ? AppLanguage.en : AppLanguage.ar;

    // page info
    final pageInfo = PageInfo();

    // filters
    final filters = [
      FilterModel(field: "is_commercial", value: "$isCommercial")
    ];

    // init params
    final params = FetchListParams(
        appLanguage: appLanguage, pageInfo: pageInfo, filters: filters);

    // fetch unit type names
    final either = await getUnitTypesByAreaCase(params);

    either.fold(
          //==> error
            (appError) => emit(ErrorWhileLoadingUnitTypeNames(appError: appError)),
            //==> fetched
            (unitTypes) {
          if (unitTypes.isEmpty) {
            _emitIfNotClosed(EmptyUnitTypeNames());
          } else {
            _emitIfNotClosed(UnitTypesLoadedState(unitTypes: unitTypes));
          }
        });
  }
}
