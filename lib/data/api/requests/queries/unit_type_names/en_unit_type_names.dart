import '../../../../../common/constants/api_constants.dart';

String fetchEnglishUnitTypeNamesQuery() => """
query EnglishUnitTypeNames(\$${VariablesConstants.filters}:[DjangoFilterInput],\$${VariablesConstants.pageInfo}:PageInfo){
  
  # query 
  unitTypeNames
  
  ######### Query params #########
  (
     #==> Page info
     pageInfo: \$${VariablesConstants.pageInfo}
      #==> filters      
     filters:\$${VariablesConstants.filters}
  )
  ########## End of params ###########
  
  ######### Query body #########
  {
    id
    name
    isCommercial
    priority
  }
  ########## end of body #########
  
}
 """;