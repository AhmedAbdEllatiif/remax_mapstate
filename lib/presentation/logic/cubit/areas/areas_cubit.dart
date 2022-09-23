import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/area_entity.dart';
import 'package:remax_mapstate/domain/use_cases/get_areas.dart';

import '../../../../domain/entities/params/no_params.dart';

part 'areas_state.dart';

class AreasCubit extends Cubit<AreasState> {
  final GetAreasCase getAreas;

  AreasCubit({required this.getAreas}) : super(LoadingAreas());


  /// fetch areas
  void fetchAreas() async {
    _emitIfNotClosed(LoadingAreas());

    final response = await getAreas(NoParams());
    response.fold(
      (appError) =>
          _emitIfNotClosed(ErrorWhileLoadingAreas(appError: appError)),
      (areas) => _emitIfNotClosed(AreasFetched(areas: areas)),
    );
  }

  /// emit if not closed
  void _emitIfNotClosed(AreasState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
