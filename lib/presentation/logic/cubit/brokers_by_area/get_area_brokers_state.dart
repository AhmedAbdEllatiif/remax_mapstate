part of 'get_area_brokers_cubit.dart';

abstract class GetAreaBrokersState extends Equatable {
  const GetAreaBrokersState();
  @override
  List<Object> get props => [];
}

/// initial
class AreaBrokersInitial extends GetAreaBrokersState {}

/// AreaBrokersLoadedState
class AreaBrokersFetched extends GetAreaBrokersState {

  final List<BrokerEntity> brokers;

  const AreaBrokersFetched({
    required this.brokers,
  });

  @override
  List<Object> get props => [brokers];
}

/// loading
class LoadingAreaBrokers extends GetAreaBrokersState{}

/// NoBrokerInArea
class NoBrokerInArea extends GetAreaBrokersState{}


/// AreaBrokersErrorState
class ErrorWhileLoadingAreaBrokers extends GetAreaBrokersState {
  final AppError appError;

  const ErrorWhileLoadingAreaBrokers({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
