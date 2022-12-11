import 'package:equatable/equatable.dart';

import '../../common/enums/filter_clause.dart';

List<Map<String, dynamic>> listOfFilterToJson(List<FilterModel> filters) =>
    filters.map((singleFilter) => singleFilter.toJson()).toList();

class FilterModel extends Equatable {
  final String field;
  final dynamic value;
  final FilterClause clause;

  const FilterModel({
    required this.field,
    required this.value,
    this.clause = FilterClause.icontains,
  });

  Map<String, dynamic> toJson() {
    return {
      "field": field,
      "value": value,
      "clause": clause.toShortString(),
    };
  }

  @override
  List<Object?> get props => [
        field,
        value,
        clause,
      ];
}
