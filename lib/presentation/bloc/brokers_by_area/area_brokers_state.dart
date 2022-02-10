part of 'area_brokers_bloc.dart';

abstract class AreaBrokersState extends Equatable {
  const AreaBrokersState();
  @override
  List<Object> get props => [];
}

class AreaBrokersInitial extends AreaBrokersState {}

/// AreaBrokersLoadedState
class AreaBrokersLoadedState extends AreaBrokersState {

  final List<BrokerEntity> brokers;

  const AreaBrokersLoadedState({
    required this.brokers,
  });

  @override
  List<Object> get props => [brokers];
}

/// loading
class AreaBrokersLoadingState extends AreaBrokersState{}

/// NoBrokerInArea
class NoBrokerInArea extends AreaBrokersState{}


/// AreaBrokersErrorState
class AreaBrokersErrorState extends AreaBrokersState {
  final AppError appError;

  const AreaBrokersErrorState({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
