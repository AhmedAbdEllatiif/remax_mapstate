part of 'broker_changed_cubit.dart';

abstract class BrokerChangedState extends Equatable {
  final BrokerEntity? brokerEntity;
  const BrokerChangedState({this.brokerEntity});

  @override
  List<Object?> get props => [];

}


class BrokerChangedInitialState  extends BrokerChangedState{}


class OnBrokerChangedState extends BrokerChangedState{
  final BrokerEntity brokerEntity;

  const OnBrokerChangedState({required this.brokerEntity});

  @override
  List<Object> get props => [brokerEntity.id];
}



