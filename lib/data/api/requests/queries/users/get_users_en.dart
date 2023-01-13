import '../../../../../common/constants/api_constants.dart';

String getBuyerUsersEnglishQuery() => """
query getBroker(
\$${VariablesConstants.pk}:Int,
\$${VariablesConstants.filters}:[DjangoFilterInput],
\$${VariablesConstants.pageInfo}:PageInfo
){
  
  # query 
  users
  
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
         dateOfBirth 
      } # end of mapEstateUser
      
    } # end of user
    
  ########## end of body #########
  }
}
 """;
