import '../../common/enums/filter_clause.dart';

List<Map<String,dynamic>> listOfFilterToJson(List<FilterModel> filters) =>
    filters.map((singleFilter) => singleFilter.toJson()).toList();



class FilterModel {
  final String field;
  final dynamic value;
  final FilterClause clause;

  FilterModel({
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
}
