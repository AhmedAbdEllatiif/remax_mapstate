String fetchEnFilterDataQuery() => """
query filterData{  
  regions{
    name
  }

  finishingTypes{
    name
  }

  unitTypeNames{
    name
  }

  layouts{
    name
  }
}
 """;