import '../../../../common/constants/api_constants.dart';

String loginUserMutation() => """
mutation loginUser(
\$${VariablesConstants.email}:String,
\$${VariablesConstants.password}:String!,
){
  
  # mutation name
  tokenAuth
  
  ######### mutation params #########
  (
      #==> arguments      
     email:\$${VariablesConstants.email},
     password:\$${VariablesConstants.password},
  )
  ########## End of params ###########
  
  ######### fields #########
  {
  success
  token
  errors
  user{
       id
       firstName
       email
       phone
    }
  }
  ########## end of fields #########
  
}
 """;
