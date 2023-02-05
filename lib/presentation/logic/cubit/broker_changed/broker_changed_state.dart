part of 'broker_changed_cubit.dart';

abstract class BrokerChangedState extends Equatable {
  final UserEntity? brokerEntity;
  const BrokerChangedState({this.brokerEntity});

  @override
  List<Object?> get props => [];

}


class BrokerChangedInitialState  extends BrokerChangedState{}


class OnBrokerChangedState extends BrokerChangedState{
  final UserEntity brokerEntity;

  const OnBrokerChangedState({required this.brokerEntity});

  @override
  List<Object> get props => [brokerEntity.id];
}



