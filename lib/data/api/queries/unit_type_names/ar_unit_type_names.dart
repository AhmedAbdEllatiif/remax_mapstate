import '../../../../common/constants/api_constants.dart';

String fetchArabicUnitTypeNamesQuery() => """
query ArabicUnitTypeNames(\$${VariablesConstants.filters}:[DjangoFilterInput],\$${VariablesConstants.pageInfo}:PageInfo){
  
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
    arabicName
    isCommercial
    priority
  }
  ########## end of body #########
  
}
 """;