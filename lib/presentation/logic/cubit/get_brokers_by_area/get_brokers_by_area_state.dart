part of 'get_brokers_by_area_cubit.dart';

abstract class GetBrokersByAreaState extends Equatable {
  const GetBrokersByAreaState();

  @override
  List<Object> get props => [];
}

/// initial
class GetBrokersByAreaInitial extends GetBrokersByAreaState {}

/// loading
class LoadingToGeBrokersByArea extends GetBrokersByAreaState {}

/// unAuthenticated
class UnAuthenticatedToGeBrokersByArea extends GetBrokersByAreaState {}

/// empty
class EmptyListOfBrokersInThisArea extends GetBrokersByAreaState {}

/// success
class BrokersOfAreaFetched extends GetBrokersByAreaState {
  final List<UserEntity> brokersList;

  const BrokersOfAreaFetched({required this.brokersList});

  @override
  List<Object> get props => [brokersList];
}

///error
class ErrorWhileGettingBrokersByArea extends GetBrokersByAreaState {
  final AppError appError;

  const ErrorWhileGettingBrokersByArea({required this.appError});

  @override
  List<Object> get props => [appError];
}

