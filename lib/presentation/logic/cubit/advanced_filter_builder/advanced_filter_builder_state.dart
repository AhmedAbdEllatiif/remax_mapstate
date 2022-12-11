part of 'advanced_filter_builder_cubit.dart';

abstract class AdvancedFilterBuilderState extends Equatable {
  final List<FilterModel> filters;

  const AdvancedFilterBuilderState({
    required this.filters,
  });

  @override
  List<Object?> get props => [filters, filters.length];
}

class AdvancedFilterBuilderInitial extends AdvancedFilterBuilderState {
  AdvancedFilterBuilderInitial() : super(filters: []);
}

class FiltersToAdd extends AdvancedFilterBuilderState {
  const FiltersToAdd({required List<FilterModel> filtersToAdd})
      : super(filters: filtersToAdd);
}
