import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/area_projects_param.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_residential_projects.dart';

part 'residential_projects_state.dart';

class ResidentialProjectsCubit extends Cubit<ResidentialProjectsState> {

  final GetResidentialProjectsCase residentialProjectsCase;


  ResidentialProjectsCubit({required this.residentialProjectsCase})
      : super(ResidentialProjectsInitial());


  void loadResidentialProjects(int areaId) async {
    emit(ResidentialProjectsLoadingState());
    Future.delayed(const Duration(milliseconds: 3000),() async {
      final response = await residentialProjectsCase(
          AreaProjectsParam(areaId: areaId));

      response.fold((appError) =>
          emit(ResidentialProjectsErrorState(appError: appError)),
              (projects) {
            if(projects.isEmpty) {
              emit(NoResidentialProjectsToShowState());
            } else {
              emit(ResidentialProjectsLoadedState(projects: projects));
            }

          });
    });

  }

}
