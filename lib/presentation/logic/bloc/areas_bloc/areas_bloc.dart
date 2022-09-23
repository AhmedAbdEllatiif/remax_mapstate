import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/repositories/api_repository.dart';
import 'package:remax_mapstate/domain/use_cases/get_areas.dart';

import '../../../../domain/entities/params/no_params.dart';

part 'areas_event.dart';

part 'areas_state.dart';

class AreasBloc extends Bloc<AreasEvent, AreasState> {
  final GetAreasCase getAreas;

  AreasBloc({required this.getAreas}) : super(AreasLoadingState()) {
    on<AreasEvent>((event, emit) async {

      void _emitIfNotClosed(AreasState state){
        if(!isClosed){
          emit(state);
        }
      }

      if (event is LoadAreasEvent) {
        final response = await getAreas(NoParams());
        response.fold(
          (appError) => _emitIfNotClosed(AreasErrorState(appError: appError)),
          (areas) => _emitIfNotClosed(AreasLoadedState(areas: areas)),
        );
      }
    });
  }
}
