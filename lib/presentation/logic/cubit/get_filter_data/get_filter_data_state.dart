part of 'get_filter_data_cubit.dart';

abstract class GetFilterDataState extends Equatable {
  const GetFilterDataState();

  @override
  List<Object> get props => [];
}

/// initial
class GetFilterDataInitial extends GetFilterDataState {}

/// loading
class LoadingGetFilterData extends GetFilterDataState {}

/// fetched
class FilterDataFetched extends GetFilterDataState {
  final FilterDataEntity filterDataEntity;

  const FilterDataFetched({required this.filterDataEntity});

  @override
  List<Object> get props => [filterDataEntity];
}

/// error
class ErrorWhileGettingFilterData extends GetFilterDataState {
  final AppError appError;

  const ErrorWhileGettingFilterData({required this.appError});

  @override
  List<Object> get props => [appError];
}
