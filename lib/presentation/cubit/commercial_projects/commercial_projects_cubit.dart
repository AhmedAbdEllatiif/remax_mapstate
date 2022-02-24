import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/params/area_projects_param.dart';
import 'package:remax_mapstate/domain/entities/project_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_commercial_projects.dart';

part 'commercial_projects_state.dart';

class CommercialProjectsCubit extends Cubit<CommercialProjectsState> {
  final GetCommercialProjectsCase commercialProjectsCase;

  CommercialProjectsCubit({required this.commercialProjectsCase})
      : super(CommercialProjectsInitial());

  void _emitIfNotClosed(CommercialProjectsState state){
    if(!isClosed){
      emit(state);
    }
  }


  void loadCommercialProjects(int areaId) async {
    emit(CommercialProjectsLoadingState());
    Future.delayed(const Duration(milliseconds: 3000), () async {
      final response =
          await commercialProjectsCase(AreaProjectsParam(areaId: areaId));

      response.fold(
          (appError) => emit(CommercialProjectsErrorState(appError: appError)),
          (projects) {
        if (projects.isEmpty) {
          _emitIfNotClosed(NoCommercialProjectsToShowState());
        } else {
          _emitIfNotClosed(CommercialProjectsLoadedState(projects: projects));
        }
      });
    });
  }
}
