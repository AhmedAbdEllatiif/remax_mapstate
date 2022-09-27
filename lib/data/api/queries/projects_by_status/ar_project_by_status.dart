import '../../../../common/constants/api_constants.dart';

String fetchArabicProjectByStatusQuery() => """
query ArabicProjectByStatus(\$${VariablesConstants.filters}:[DjangoFilterInput],\$${VariablesConstants.pageInfo}:PageInfo){
  
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
     arabicName
     type
     priceFrom
     # developer
     developer{
       logo
     }
     # region
     region{
       id
       arabicName
     }
     # zone
     zone{
       id
       arabicName
     }
  }
  ########## end of body #########
  
}
 """;