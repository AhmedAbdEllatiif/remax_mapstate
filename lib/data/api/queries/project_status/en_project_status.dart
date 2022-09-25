import '../../../../common/constants/api_constants.dart';

String fetchEnglishProjectStatusQuery() => """
query EnglishProjectStatus(\$${VariablesConstants.filters}:[DjangoFilterInput],\$${VariablesConstants.pageInfo}:PageInfo){
  
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
    name
  }
  ########## end of body #########
  
}
 """;
