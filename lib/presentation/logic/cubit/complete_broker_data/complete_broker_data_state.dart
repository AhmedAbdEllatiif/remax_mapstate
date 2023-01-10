part of 'complete_broker_data_cubit.dart';

abstract class CompleteBrokerDataState extends Equatable {
  const CompleteBrokerDataState();

  @override
  List<Object> get props => [];
}

/// initial
class CompleteBrokerDataInitial extends CompleteBrokerDataState {}

/// loading
class LoadingCompleteBrokerDataInitial extends CompleteBrokerDataState {}

/// experience years must be a number
class ExperienceYearsMustBeANumber  extends CompleteBrokerDataState {}

/// unAuthorized
class UnAuthorizedCompleteBrokerDataInitial extends CompleteBrokerDataState {}

/// success
class BrokerDataCompletedSuccessfully extends CompleteBrokerDataState {}

/// error
class ErrorWhileCompletingBrokerData extends CompleteBrokerDataState {
  final AppError appError;

  const ErrorWhileCompletingBrokerData({required this.appError});

  @override
  List<Object> get props => [appError];
}
