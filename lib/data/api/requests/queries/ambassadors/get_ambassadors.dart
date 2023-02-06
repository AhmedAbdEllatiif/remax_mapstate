import '../../../../../common/constants/api_constants.dart';

String getAmbassadorsQuery() => """
query getBroker(
\$${VariablesConstants.pk}:Int,
\$${VariablesConstants.filters}:[DjangoFilterInput],
\$${VariablesConstants.pageInfo}:PageInfo
){
  
  # query 
  ambassadors
  
  ######### Query params #########
  (
     #==> pk
     pk: \$${VariablesConstants.pk}
      #==> Page info
     pageInfo: \$${VariablesConstants.pageInfo}
      #==> filters      
     filters:\$${VariablesConstants.filters}
  ){
  ########## End of params ###########
  
  ######### Query body #########
  
  user {
      id
      email
      phone
      firstName
      lastName
      
       mapEstateUser{
         avatar 
      } # end of mapEstateUser
      
    } # end of user
    
    dateOfBirth 
    currentJobTitle
    doneDealsCount
  ########## end of body #########
  }
}
 """;
