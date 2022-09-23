import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:remax_mapstate/di/git_it.dart';
import 'package:remax_mapstate/domain/entities/app_error.dart';
import 'package:remax_mapstate/domain/entities/broker_entity.dart';
import 'package:remax_mapstate/domain/entities/params/no_params.dart';
import 'package:remax_mapstate/domain/use_cases/get_area_brokers.dart';

part 'get_area_brokers_state.dart';

class GetAreaBrokersCubit extends Cubit<GetAreaBrokersState> {
  GetAreaBrokersCubit() : super(AreaBrokersInitial());

  /// fetch brokers
  void fetchBrokers() async {
    _emitIfNotClosed(LoadingAreaBrokers());

    // init GetAreaBrokersCase
    GetAreaBrokersCase getAreaBrokersCase = getItInstance<GetAreaBrokersCase>();

    // fetch brokers
    final either = await getAreaBrokersCase(NoParams());

    either.fold(
        (appError) =>
            _emitIfNotClosed(ErrorWhileLoadingAreaBrokers(appError: appError)),
        (brokers) => {
              if (brokers.isEmpty)
                _emitIfNotClosed(NoBrokerInArea())
              else
                _emitIfNotClosed(AreaBrokersFetched(brokers: brokers))
            });
  }

  /// emit if not closed
  void _emitIfNotClosed(GetAreaBrokersState state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
