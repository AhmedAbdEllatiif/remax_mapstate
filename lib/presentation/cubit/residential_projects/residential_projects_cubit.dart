import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/area_projects_param.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/entities/unit_type_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_residential_projects.dart';
import 'package:remax_mapstate/domain/use_cases/get_unit_types_by_area.dart';

part 'residential_projects_state.dart';

class ResidentialCubit extends Cubit<ResidentialState> {
  final GetResidentialProjectsCase residentialProjectsCase;
  final GetResidentialUnitTypesByAreaCase getUnitTypesByAreaCase;

  ResidentialCubit(
      {required this.getUnitTypesByAreaCase,
      required this.residentialProjectsCase})
      : super(ResidentialInitial());

  void emitIfNotClosed(ResidentialState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  /// loadUnitTypes
  void loadUnitTypes(int areaId) async {
    emit(ResidentialLoadingState());
    Future.delayed(const Duration(milliseconds: 3000), () async {
      final response = await getUnitTypesByAreaCase(NoParams());

      response.fold(
          (appError) => emit(ResidentialCubitErrorState(appError: appError)),
          (unitTypes) {
        if (unitTypes.isEmpty) {
          emitIfNotClosed(NoUnitTypesToShowState());
        } else {
          emitIfNotClosed(UnitTypesLoadedState(unitTypes: unitTypes));
        }
      });
    });
  }

  /// loadProjects
  void loadProjects(int areaId) async {
    emit(ResidentialLoadingState());
    Future.delayed(const Duration(milliseconds: 3000), () async {
      final response =
          await residentialProjectsCase(AreaProjectsParam(areaId: areaId));

      response.fold(
          (appError) => emit(ResidentialCubitErrorState(appError: appError)),
          (projects) {
        if (projects.isEmpty) {
          emitIfNotClosed(NoProjectsToShowState());
        } else {
          emitIfNotClosed(ProjectsLoadedState(projects: projects));
        }
      });
    });
  }
}
