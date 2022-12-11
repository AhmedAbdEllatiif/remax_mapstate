
/// to build a list of years start from current year
List<String> yearsList({required countOfYears}) {
  final List<String> years = [];
  for (var i = 0; i < countOfYears; i++) {
    years.add((DateTime.now().year + i).toString());
  }
  return years;
}
