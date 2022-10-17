String fetchArFilterDataQuery() => """
query filterData{  
  regions{
    arabicName
  }

  finishingTypes{
    arabicName
  }

  unitTypeNames{
    arabicName
  }

  layouts{
    arabicName
  }
}
 """;