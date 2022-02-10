part of 'area_brokers_bloc.dart';

abstract class AreaBrokersEvent extends Equatable {
  const AreaBrokersEvent();

  @override
  List<Object?> get props => [];
}

class LoadAreaBrokersEvent extends AreaBrokersEvent{}

class AreaBrokersLoadingEvent extends AreaBrokersEvent{}


