part of 'search_filter_builder_cubit.dart';

abstract class SearchFilterBuilderState extends Equatable {
  final List<FilterModel> filters;

  const SearchFilterBuilderState({
    required this.filters,
  });

  @override
  List<Object?> get props => [filters, filters.length];
}

/// initial
class AdvancedFilterBuilderInitial extends SearchFilterBuilderState {
  AdvancedFilterBuilderInitial() : super(filters: []);
}

/// filters to add
class FiltersBuiltSuccessfully extends SearchFilterBuilderState {
  const FiltersBuiltSuccessfully({required List<FilterModel> filtersToAdd})
      : super(filters: filtersToAdd);
}
