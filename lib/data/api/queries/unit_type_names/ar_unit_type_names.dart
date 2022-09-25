import '../../../../common/constants/api_constants.dart';

String fetchArabicUnitTypeNamesQuery() => """
query ArabicUnitTypeNames(\$${VariablesConstants.filters}:[DjangoFilterInput],\$${VariablesConstants.limit}:Int,\$${VariablesConstants.offset}:Int,\$${VariablesConstants.orderBy}:String){
  
  # query 
  unitTypeNames
  
  ######### Query params #########
  (
     #==> Page info
     pageInfo:{
         limit:\$${VariablesConstants.limit},
         offset:\$${VariablesConstants.offset},
         orderBy:\$${VariablesConstants.orderBy}
            }
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