part of 'get_buyer_by_id_cubit.dart';

abstract class GetBuyerByIdState extends Equatable {
  const GetBuyerByIdState();
  @override
  List<Object> get props => [];
}

/// initial
class GetBuyerByIdInitial extends GetBuyerByIdState {}

/// loading
class LoadingGetBuyerById extends GetBuyerByIdState {}

/// unAuthorized
class UnAuthorizedToGetBuyerById extends GetBuyerByIdState {}


/// NotABrokerBeforeGettingBrokerById
/// this means the buyer id == -1
class NotABuyerBeforeGettingBuyerById extends GetBuyerByIdState {}

/// success
class BuyerDataFetched extends GetBuyerByIdState {
  final UserEntity userEntity;

  const BuyerDataFetched({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}

/// error
class ErrorWhileGettingBuyerById extends GetBuyerByIdState {
  final AppError appError;

  const ErrorWhileGettingBuyerById({
    required this.appError,
  });

  @override
  List<Object> get props => [appError];
}