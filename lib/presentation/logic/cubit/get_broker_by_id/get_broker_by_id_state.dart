part of 'get_broker_by_id_cubit.dart';

abstract class GetBrokerByIdState extends Equatable {
  const GetBrokerByIdState();

  @override
  List<Object> get props => [];
}

/// initial
class GetBrokerByIdInitial extends GetBrokerByIdState {}

/// loading
class LoadingGetBrokerById extends GetBrokerByIdState {}

/// unAuthorized
class UnAuthorizedToGetBrokerById extends GetBrokerByIdState {}

/// NotABrokerBeforeGettingBrokerById
class NotABrokerBeforeGettingBrokerById extends GetBrokerByIdState {}

/// not a completed broker data
class NotCompletedDataForBroker extends GetBrokerByIdState {
  final UserEntity userEntity;

  const NotCompletedDataForBroker({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}

/// success
class BrokerDataFetched extends GetBrokerByIdState {
  final UserEntity userEntity;

  const BrokerDataFetched({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}

/// error
class ErrorWhileGettingBrokerById extends GetBrokerByIdState {
  final AppError appError;

  const ErrorWhileGettingBrokerById({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}
