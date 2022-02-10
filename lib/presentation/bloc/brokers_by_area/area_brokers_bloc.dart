import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/use_cases/get_area_brokers.dart';

part 'area_brokers_event.dart';

part 'area_brokers_state.dart';

class AreaBrokersBloc extends Bloc<AreaBrokersEvent, AreaBrokersState> {
  final GetAreaBrokersCase getAreaBrokersCase;

  AreaBrokersBloc({required this.getAreaBrokersCase})
      : super(AreaBrokersLoadingState()) {
    on<AreaBrokersEvent>((event, emit) async {
      /// loading
      /*if (event is LoadAreaBrokersEvent) {
        emit(AreaBrokersLoadingState());
      }*/

      /// loaded
      if (event is LoadAreaBrokersEvent) {
        final response = await getAreaBrokersCase(NoParams());
        response.fold(
            (appError) => emit(AreaBrokersErrorState(appError: appError)),
            (brokers) => {
              if(brokers.isEmpty)
                emit(NoBrokerInArea())
              else
                emit(AreaBrokersLoadedState(brokers: brokers))
            });
      }
    });
  }
}
