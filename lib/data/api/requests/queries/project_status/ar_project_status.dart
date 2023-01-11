import '../../../../../common/constants/api_constants.dart';

String fetchArabicProjectStatusQuery() => """
query ArabicProjectStatus(\$${VariablesConstants.filters}:[DjangoFilterInput],\$${VariablesConstants.pageInfo}:PageInfo){
  
  # query 
  projectStatuses
  
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
  }
  ########## end of body #########
  
}
 """;