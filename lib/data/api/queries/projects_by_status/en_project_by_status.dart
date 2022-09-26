import '../../../../common/constants/api_constants.dart';

String fetchEnglishProjectByStatusQuery() => """
query EnglishProjectByStatus(\$${VariablesConstants.filters}:[DjangoFilterInput],\$${VariablesConstants.pageInfo}:PageInfo){
  
  # query 
  projects
  
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
     type
     priceFrom
     # developer
     developer{
       logo
     }
     # region
     region{
       id
       name
     }
     # zone
     zone{
       id
       name
     }
  }
  ########## end of body #########
  
}
 """;