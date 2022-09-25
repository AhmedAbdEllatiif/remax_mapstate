enum FilterClause {
  exact,
  iexact,
  contains,
  icontains,
  values_in,
  gt,
  lt,
  gte,
  lte,
  date__gt,
  date__lt,
  date__gte,
  date__lte,
  time__gt,
  time__lt,
  time__gte,
  time__lte,
}

/// Extension to convert FilterClause to string
extension ToString on FilterClause {
  String toShortString() {
    return toString().split('.').last;
  }
}
